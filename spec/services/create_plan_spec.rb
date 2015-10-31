require 'spec_helper'

describe Service::Plan::Create do
  let(:host) { create(:user) }
  let(:plan) { PlanForm.new(Plan.new) }
  let(:fixtures) { { where: 'here', what: 'that', price: 80 } }
  let(:local_time) { "31/08/2014 16:00" }
  let(:local_timezone) { local_time + ' ' + timezone }
  let(:timezone) { 'Central Time (US & Canada)' }
  let(:params) { { when: local_time, deadline: "01/06/2014 12:00", timezone: timezone  } }
  let(:time_format) { Plan.datetimezone_format }
  let(:subject) { ::Service::Plan::Create.call(host, plan, params.merge(fixtures))}

  context 'success :)' do
    
    it 'creates a plan' do
      expect(Hopscotch::Step).to receive(:success!)
      expect{ subject }.to change{ Plan.count }.by(1)
    end

    it 'parses dates correctly' do
      subject
      expect(Plan.last.when).to eq DateTime.strptime(local_timezone, time_format).utc
      expect(Plan.last.when.zone).to eq 'UTC'
    end

    it 'assigns a host to the plan' do
      subject
      expect(plan.host).to eq host
    end
  end

  context 'fail :(' do
    before { allow(plan).to receive(:validate).and_return(false) }
    it do
      expect(Hopscotch::Step).to receive(:failure!).with(plan)
      subject
    end
  end
end
