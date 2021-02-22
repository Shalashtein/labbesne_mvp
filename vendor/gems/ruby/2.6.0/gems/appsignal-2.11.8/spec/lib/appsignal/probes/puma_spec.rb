require "appsignal/probes/puma"

describe Appsignal::Probes::PumaProbe do
  before(:context) do
    Appsignal.config = project_fixture_config
  end
  after(:context) do
    Appsignal.config = nil
  end

  let(:probe) { described_class.new }

  describe "hostname" do
    it "returns the socket hostname" do
      expect(probe.send(:hostname)).to eql(Socket.gethostname)
    end

    context "with overridden hostname" do
      around do |sample|
        Appsignal.config[:hostname] = "frontend1"
        sample.run
        Appsignal.config[:hostname] = nil
      end
      it "returns the configured host" do
        expect(probe.send(:hostname)).to eql("frontend1")
      end
    end
  end

  describe "#call" do
    let(:expected_default_tags) { { :hostname => Socket.gethostname } }

    context "with multiple worker stats" do
      before(:context) do
        class Puma
          def self.stats
            {
              "workers" => 2,
              "booted_workers" => 2,
              "old_workers" => 0,
              "worker_status" => [
                {
                  "last_status" => {
                    "backlog" => 0,
                    "running" => 5,
                    "pool_capacity" => 5,
                    "max_threads" => 5
                  }
                },
                {
                  "last_status" => {
                    "backlog" => 0,
                    "running" => 5,
                    "pool_capacity" => 5,
                    "max_threads" => 5
                  }
                }
              ]
            }.to_json
          end
        end
      end
      after(:context) { Object.send(:remove_const, :Puma) }

      it "calls `puma_gauge` with the (summed) worker metrics" do
        expect_gauge(:workers, 2, :type => :count)
        expect_gauge(:workers, 2, :type => :booted)
        expect_gauge(:workers, 0, :type => :old)

        expect_gauge(:connection_backlog, 0)
        expect_gauge(:pool_capacity, 10)
        expect_gauge(:threads, 10, :type => :running)
        expect_gauge(:threads, 10, :type => :max)

        probe.call
      end
    end

    context "with single worker stats" do
      before(:context) do
        class Puma
          def self.stats
            {
              "backlog" => 0,
              "running" => 5,
              "pool_capacity" => 5,
              "max_threads" => 5
            }.to_json
          end
        end
      end
      after(:context) { Object.send(:remove_const, :Puma) }

      it "calls `puma_gauge` with the (summed) worker metrics" do
        expect_gauge(:connection_backlog, 0)
        expect_gauge(:pool_capacity, 5)
        expect_gauge(:threads, 5, :type => :running)
        expect_gauge(:threads, 5, :type => :max)
        probe.call
      end
    end

    context "without stats" do
      before(:context) do
        class Puma
          def self.stats
          end
        end
      end
      after(:context) { Object.send(:remove_const, :Puma) }

      context "when it returns nil" do
        it "does not track metrics" do
          expect(probe).to_not receive(:puma_gauge)
          probe.call
        end
      end

      # Puma.stats raises a NoMethodError on a nil object on the first call.
      context "when it returns a NoMethodError on the first call" do
        let(:log) { StringIO.new }

        it "ignores the first call and tracks the second call" do
          use_logger_with log do
            expect(Puma).to receive(:stats)
              .and_raise(NoMethodError.new("undefined method `stats' for nil:NilClass"))
            probe.call

            expect(Puma).to receive(:stats).and_return({
              "backlog" => 1,
              "running" => 5,
              "pool_capacity" => 4,
              "max_threads" => 6
            }.to_json)

            expect_gauge(:connection_backlog, 1)
            expect_gauge(:pool_capacity, 4)
            expect_gauge(:threads, 5, :type => :running)
            expect_gauge(:threads, 6, :type => :max)
            probe.call
          end

          expect(log_contents(log)).to_not contains_log(:error, "Error in minutely probe 'puma'")
        end
      end

      context "when it does not have a complete stats payload" do
        let(:log) { StringIO.new }

        it "tracks whatever metrics we do have" do
          use_logger_with log do
            expect(Puma).to receive(:stats).and_return({
              "backlog" => 1,
              "running" => 5
            }.to_json)

            expect_gauge(:connection_backlog, 1)
            expect_no_gauge(:pool_capacity)
            expect_gauge(:threads, 5, :type => :running)
            expect_no_gauge(:threads, :type => :max)
            probe.call
          end

          expect(log_contents(log)).to_not contains_log(:error, "Error in minutely probe 'puma'")
        end
      end
    end

    def expect_gauge(key, value, tags = {})
      expect(Appsignal).to receive(:set_gauge)
        .with("puma_#{key}", value, expected_default_tags.merge(tags))
        .and_call_original
    end

    def expect_no_gauge(key, tags = {})
      expect(Appsignal).to_not receive(:set_gauge)
        .with("puma_#{key}", anything, tags)
    end
  end
end
