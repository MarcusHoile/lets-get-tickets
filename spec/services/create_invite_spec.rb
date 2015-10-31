require 'spec_helper'

describe Service::Plan::Invite::Create do
  let(:invite) { InviteForm.new(Invite.new) }
  let(:plan) { create(:plan) }
  let(:user) { create(:user) }
  let(:rsvp) { 'going' }

  it 'creates an invite' do
    expect(Hopscotch::Step).to receive(:success!)
    expect{ subject.call(invite, plan, user, rsvp) }.to change{ Invite.count }.by(1)
  end

  context 'invalid params' do
    before { allow(invite).to receive(:validate).and_return(false) }
    it do
      expect(Hopscotch::Step).to receive(:failure!)
      subject.call(invite, plan, user, rsvp)
    end
  end
end
