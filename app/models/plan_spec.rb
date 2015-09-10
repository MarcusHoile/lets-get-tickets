require 'spec_helper'

describe Plan do
  let(:host) { create :user }
  let(:user) { create :user }
  let(:plan) { create :plan, host: host }
  let(:confirmed_plan) { create :confirmed_plan }
  let(:closed_plan) { create :plan, :closed }
  let(:open_plan) { create :plan, :open }
  let(:booked_plan) { create :plan, :booked }


  describe '#host?' do
    it 'is true when plan host' do
      expect(plan.host?(host)).to eq true
      expect(plan.host?(user)).to eq false
    end
  end

  describe '#no_invites?' do
    let!(:host_invite) { create :invite, plan: plan, guest: host }

    it 'true when no guests' do
      expect(plan.no_invites?).to eq true
    end
    
    context 'has invites' do
      let!(:invite) { create :invite, plan: plan }
      
      it 'is false' do
        expect(plan.no_invites?).to eq false
      end
    end
  end

  context 'is booked' do
    let(:plan) { create :plan, booked: true }
    
    describe '#booked?' do
      it 'is true' do
        expect(plan.booked?).to eq true
      end
    end

    describe '#not_booked?' do
      it 'is false' do
        expect(plan.not_booked?).to eq false
      end
    end
  end

  context 'NOT booked' do
    let(:plan) { create :plan, booked: false }
    
    describe '#booked?' do
      it 'is false' do
        expect(plan.booked?).to eq false
      end
    end

    describe '#not_booked?' do
      it 'is true' do
        expect(plan.not_booked?).to eq true
      end
    end
  end

  describe '#confirmed?' do
    it 'is true for confirmed plans' do
      expect(confirmed_plan.confirmed?).to eq true
      expect(booked_plan.confirmed?).to eq false
      expect(closed_plan.confirmed?).to eq false
    end
  end

  describe '#unconfirmed?' do
    it 'is true for unconfirmed plans' do
      expect(confirmed_plan.unconfirmed?).to eq false
      expect(booked_plan.unconfirmed?).to eq true
      expect(closed_plan.unconfirmed?).to eq true
    end
  end
  
  describe '#open?' do
    it 'is true' do
      expect(open_plan.open?).to eq true
    end
    it 'is false' do
      expect(closed_plan.open?).to eq false
    end
  end

  describe '#closed?' do
    it 'is true' do
      expect(closed_plan.closed?).to eq true
    end
    it 'is false' do
      expect(open_plan.closed?).to eq false
    end
  end

  describe '#booking_reminder?' do
    it 'is true' do
      expect(closed_plan.booking_reminder?).to eq true
    end
    it 'is false' do
      expect(confirmed_plan.booking_reminder?).to eq false
    end
  end

  describe '#check_status' do
    let(:past_deadline) { create :plan, deadline: 1.day.ago, status: 'open' }

    before do
      past_deadline.check_status
    end

    it 'changes status to closed' do
      expect(past_deadline.status).to eq 'closed'
    end
  end
end
