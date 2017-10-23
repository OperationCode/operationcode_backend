module Api
  module V1
    class GitHubStatisticsController < ApplicationController
      def oc_totals
        render json: GitHub::Presenter.new(params).oc_totals, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def totals_by_repository
        render json: GitHub::Presenter.new(params).totals_by_repository, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def totals_for_user
        render json: GitHub::Presenter.new(params).totals_for_user, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def totals_for_user_in_repository
        render json: GitHub::Presenter.new(params).totals_for_user_in_repository, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def oc_averages
        render json: GitHub::Presenter.new(params).oc_averages, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
