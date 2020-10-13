require 'project'

describe Project do
  let(:project) do
    Project.new(
      title:         'Behaviour Driven Development',
      amount_before: 10_000.89,
      amount_after:  9_876.43,
      project_type:  :planned,
      start_on:      Date.new(2022, 2),
      end_on:        Date.new(2022, 2) + 6
    )
  end

  context 'class_methods' do
    it 'lists available project types' do
      expect(described_class.available_project_types).to eq(%i[planned in_progress completed cancelled])
    end
  end

  context 'instance' do
    it 'computes savings' do
      expect(project.computed_savings).to eq(124.46)
    end

    it 'computes duration' do
      expect(project.duration).to eq(7)
    end

    it 'defines days array' do
      expect(project.days_array).to eq(%w[2022-03-01 2022-03-02 2022-03-03 2022-03-04 2022-03-05 2022-03-06 2022-03-07])
    end

    it 'defines remaining days number before end' do
      expect(Date).to receive(:current).once.and_return(Date.new(2022, 2) + 3)
      expect(project.remaining_days_number).to eq(3)
    end

    it 'computes daily savings linear repartition' do
      expect(project.daily_savings_repartitions).to eq(
        {
          '2022-03-01' => 17.78,
          '2022-03-02' => 17.78,
          '2022-03-03' => 17.78,
          '2022-03-04' => 17.78,
          '2022-03-05' => 17.78,
          '2022-03-06' => 17.78,
          '2022-03-07' => 17.78
        }
      )
    end
  end
end
