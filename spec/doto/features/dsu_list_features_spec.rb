# frozen_string_literal: true

RSpec.describe 'Doto list features', type: :feature do
  subject(:cli) { Doto::CLI.start(args) }

  shared_examples 'the entry group is listed' do
    let(:expected_output) do
      Doto::Services::StdoutRedirectorService.call do
        view_entry_groups(times)
      end
    end

    it 'lists the entry group entries for the dates' do
      escaped_expected_output = Regexp.escape(expected_output)

      expect { cli }.to output(/.*#{escaped_expected_output}.*/m).to_stdout
    end
  end

  shared_examples 'an error is displayed to stderr' do
    it 'lists the entry group entries for the dates' do
      escaped_expected_output = Regexp.escape(expected_output)

      expect { cli }.to output(/.*#{escaped_expected_output}.*/m).to_stderr
    end
  end

  before do
    [-3, -2, -1, 0, 1, 2, 3].each do |index|
      time = Time.now.in_time_zone + index.days
      create(:entry_group, :with_entries, time: time)
    end
  end

  let(:options) { {} }
  let(:configuration) do
    build(:configuration)
  end

  context "when 'doto help list' is used" do
    let(:args) { %w[help list] }

    it 'displays help' do
      expect { cli }.to output(/Commands:.*rspec list/m).to_stdout
    end
  end

  context "when 'doto list date DATE|MNEMONIC' is used" do
    context 'with no DATE | MNEMONIC argument' do
      let(:args) { %w[list date] }
      let(:expected_output) do
        'ERROR: "rspec list date" was called with no arguments'
      end

      it_behaves_like 'an error is displayed to stderr'
    end

    context 'with a date' do
      let(:args) { ['list', 'date', Doto::Support::TimeFormatable.yyyy_mm_dd(time: time, separator: '/')] }
      let(:time) { Time.now.in_time_zone }
      let(:times) do
        [time, time.yesterday]
      end

      it_behaves_like 'the entry group is listed'
    end

    context 'with a mnemonic' do
      context "with '+n'" do
        let(:args) { %w[list date +1] }
        # + 1.day to reflect our +1 mnemonic
        let(:time) { Time.now + 1.day }
        let(:times) { [time, time.yesterday] }

        it_behaves_like 'the entry group is listed'
      end

      context "with '-n'" do
        let(:args) { %w[list date -1] }
        # - 1.day to reflect our -1 mnemonic
        let(:time) { Time.now - 1.day }
        let(:times) { [time.yesterday, time] }

        it_behaves_like 'the entry group is listed'
      end

      context "with 'today'" do
        let(:args) { %w[list date today] }
        let(:times) { [Time.now.yesterday, Time.now] }

        it_behaves_like 'the entry group is listed'
      end

      context "with 'tomorrow'" do
        let(:args) { %w[list date tomorrow] }
        let(:times) { [Time.now, Time.now.tomorrow] }

        it_behaves_like 'the entry group is listed'
      end

      context "with 'yesterday'" do
        let(:args) { %w[list date yesterday] }
        let(:times) { [Time.now.yesterday, Time.now.yesterday.yesterday] }

        it_behaves_like 'the entry group is listed'
      end
    end
  end

  context "when 'doto list dates OPTIONS' is used" do
    context 'with no OPTIONS or OPTION values' do
      let(:args) do
        %w[
          list
          dates
        ]
      end
      let(:expected_output) do
        "No value provided for required options '--from', '--to'"
      end

      it_behaves_like 'an error is displayed to stderr'
    end

    context 'with no --from or --to OPTION values' do
      let(:args) do
        [
          'list',
          'dates',
          '--from',
          '--to'
        ]
      end
      let(:expected_output) do
        "No value provided for option '--from'"
      end

      it_behaves_like 'an error is displayed to stderr'
    end

    context 'with invalid FROM_DATE | TO_DATE argument' do
      context 'with invalid FROM_DATE and invalid TO_DATE' do
        let(:args) do
          [
            'list',
            'dates',
            '--from', 'bad-from-date',
            '--to', 'bad-to-date'
          ]
        end
        let(:expected_output) do
          'Option -f, [--from=DATE|MNEMONIC] value is invalid ["bad-from-date"]'
        end

        it_behaves_like 'an error is displayed to stderr'
      end

      context 'with invalid FROM_DATE' do
        let(:args) do
          [
            'list',
            'dates',
            '--from', 'bad-date',
            '--to', Doto::Support::TimeFormatable.mm_dd(time: Time.now)
          ]
        end
        let(:expected_output) do
          'Option -f, [--from=DATE|MNEMONIC] value is invalid ["bad-date"]'
        end

        it_behaves_like 'an error is displayed to stderr'
      end

      context 'with invalid TO_DATE' do
        let(:args) do
          [
            'list',
            'dates',
            '--from', Doto::Support::TimeFormatable.mm_dd(time: Time.now),
            '--to', 'bad-date'
          ]
        end
        let(:expected_output) do
          'Option -t, [--to=DATE|MNEMONIC] value is invalid ["bad-date"]'
        end

        it_behaves_like 'an error is displayed to stderr'
      end
    end

    context "when 'doto list dates -f FROM_DATE -t TO_DATE' is used" do
      let(:args) do
        [
          'list',
          'dates',
          '-f', Doto::Support::TimeFormatable.mm_dd_yyyy(time: times.min),
          '-t', Doto::Support::TimeFormatable.mm_dd_yyyy(time: times.max)
        ]
      end
      let(:times) { [Time.now.yesterday, Time.now] }

      it_behaves_like 'the entry group is listed'
    end

    context "when 'doto list dates -f MNEMONIC -t TO_DATE' is used" do
      let(:args) do
        [
          'list',
          'dates',
          '-f', 'yesterday',
          '-t', Doto::Support::TimeFormatable.mm_dd(time: Time.now)
        ]
      end
      let(:times) { [Time.now.yesterday, Time.now] }

      it_behaves_like 'the entry group is listed'
    end

    context "when 'doto list dates -f FROM_DATE -t MNEMONIC' is used" do
      let(:args) do
        [
          'list',
          'dates',
          '-f', Doto::Support::TimeFormatable.mm_dd_yyyy(time: Time.now.yesterday),
          '-t', 'today'
        ]
      end
      let(:times) { [Time.now.yesterday, Time.now] }

      it_behaves_like 'the entry group is listed'
    end

    context "when 'doto list dates -f MNEMONIC -t MNEMONIC' is used" do
      context "when '-f MNEMONIC_STRING -t MNEMONIC_STRING'" do
        let(:args) do
          [
            'list',
            'dates',
            '-f', 'yesterday',
            '-t', 'today'
          ]
        end
        let(:times) { [Time.now.yesterday, Time.now] }

        it_behaves_like 'the entry group is listed'
      end

      context "when '-f MNEMONIC_NUM -t MNEMONIC_STRING'" do
        let(:args) do
          [
            'list',
            'dates',
            '-f', '-1',
            '-t', 'today'
          ]
        end
        let(:times) { [Time.now - 1.day, Time.now] }

        it_behaves_like 'the entry group is listed'
      end

      context "when '-f MNEMONIC_STRING -t MNEMONIC_NUM'" do
        let(:args) do
          [
            'list',
            'dates',
            '-f', 'yesterday',
            '-t', '+2'
          ]
        end
        let(:times) { [Time.now.yesterday, Time.now.yesterday + 2.days] }

        it_behaves_like 'the entry group is listed'
      end
    end
  end
end

def view_entry_groups(times)
  config_hash = configuration.to_h
  times = doto_times_for(times)
  times = Doto::Support::TimesSortable.times_sort(times: times, entries_display_order: config_hash[:entries_display_order])
  presenter = Doto::Presenters::EntryGroup::List::DatesPresenter.new(times: times, options: config_hash)
  Doto::Views::EntryGroup::List.new(presenter: presenter).render
end

def doto_times_for(times)
  from = Doto::Support::TimeFormatable.mm_dd_yyyy(time: times.min)
  to = Doto::Support::TimeFormatable.mm_dd_yyyy(time: times.max)
  times, errors = Doto::Support::CommandOptions::DotoTimes.doto_times_for(from_option: from, to_option: to)
  raise errors.join("\n") if errors.any?

  times
end
