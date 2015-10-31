module Service
  module Plan
    module Create
      extend self

      def call(host, plan, params)
        if plan.validate(parsed_attributes(host, params)) && plan.save(validate: false)
          Hopscotch::Step.success!(plan)
        else
          Hopscotch::Step.failure!(plan)
        end
      end

      private

      def parsed_attributes(host, params)
        format = ::Plan.datetimezone_format
        when_date = params[:when] + ' ' + params[:timezone]
        deadline_date = params[:deadline] + ' ' + params[:timezone]
        params[:when] = DateTime.strptime(when_date, format).utc
        params[:deadline] = DateTime.strptime(deadline_date, format).utc
        params[:host] = host
        params
      end

    end
  end
end
