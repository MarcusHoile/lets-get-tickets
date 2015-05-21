require 'spec_helper'

describe Event do
  let(:host) { create :user }
  let(:user) { create :user }
  let(:event) { create :event, host: host }
  let(:confirmed_event) { create :confirmed_event }
  let(:closed_event) { create :event, :closed }
  let(:open_event) { create :event, :open }
  let(:booked_event) { create :event, :booked }


  describe '#host?' do
    it 'is true when event host' do
      expect(event.host?(host)).to eq true
      expect(event.host?(user)).to eq false
    end
  end

  describe '#no_invites?' do
    let!(:host_invite) { create :invite, event: event, guest: host }

    it 'true when no guests' do
      expect(event.no_invites?).to eq true
    end
    
    context 'has invites' do
      let!(:invite) { create :invite, event: event }
      
      it 'is false' do
        expect(event.no_invites?).to eq false
      end
    end
  end

  context 'is booked' do
    let(:event) { create :event, booked: true }
    
    describe '#booked?' do
      it 'is true' do
        expect(event.booked?).to eq true
      end
    end

    describe '#not_booked?' do
      it 'is false' do
        expect(event.not_booked?).to eq false
      end
    end
  end

  context 'NOT booked' do
    let(:event) { create :event, booked: false }
    
    describe '#booked?' do
      it 'is false' do
        expect(event.booked?).to eq false
      end
    end

    describe '#not_booked?' do
      it 'is true' do
        expect(event.not_booked?).to eq true
      end
    end
  end

  describe '#confirmed?' do
    it 'is true for confirmed events' do
      expect(confirmed_event.confirmed?).to eq true
      expect(booked_event.confirmed?).to eq false
      expect(closed_event.confirmed?).to eq false
    end
  end

  describe '#unconfirmed?' do
    it 'is true for unconfirmed events' do
      expect(confirmed_event.unconfirmed?).to eq false
      expect(booked_event.unconfirmed?).to eq true
      expect(closed_event.unconfirmed?).to eq true
    end
  end
  
  describe '#open?' do
    it 'is true' do
      expect(open_event.open?).to eq true
    end
    it 'is false' do
      expect(closed_event.open?).to eq false
    end
  end

  describe '#closed?' do
    it 'is true' do
      expect(closed_event.closed?).to eq true
    end
    it 'is false' do
      expect(open_event.closed?).to eq false
    end
  end

  describe '#booking_reminder?' do
    it 'is true' do
      expect(closed_event.booking_reminder?).to eq true
    end
    it 'is false' do
      expect(confirmed_event.booking_reminder?).to eq false
    end
  end

  describe '#check_status' do
    let(:past_deadline) { create :event, deadline: 1.day.ago, status: 'open' }

    before do
      past_deadline.check_status
    end

    it 'changes status to closed' do
      expect(past_deadline.status).to eq 'closed'
    end
  end
end
