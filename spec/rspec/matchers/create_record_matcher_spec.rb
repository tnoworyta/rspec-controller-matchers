require "spec_helper"
require "support/controller_specs_boilerplate"
require "rspec/matchers/fail_matchers"

class User < ActiveRecord::Base
end

describe "create_record matcher", type: :controller do
  context "controller creates a record with given attributes" do
    controller do
      def create
        User.create(user_params)
      end

      def user_params
        params.require(:user).permit(:name)
      end
    end

    it "ensures that a new record for given class is created with correct attributes" do
      params = {
        user: {
          name: "Test name"
        }
      }

      expect do
        post(:create, params: params)
      end.to create_record(User, name: "Test name")
    end
  end

  context "controller does not create" do
    controller do
      def create
      end
    end

    it "ensures that a new record for given class is created with correct attributes" do
      params = {
        user: {
          name: "Test name"
        }
      }

      expect do
        expect do
          post(:create, params: params)
        end.to create_record(User, name: "Test name")
      end.to fail_with("Expected a record of User class be created, but was not")
    end
  end

  context "controller does create record, but with different attributes" do
    controller do
      def create
        User.create(user_params)
      end

      def user_params
        params.require(:user).permit(:name)
      end
    end

    it "ensures that a new record for given class is created with correct attributes" do
      params = {
        user: {
          name: "Completely different name"
        }
      }

      expect do
        expect do
          post(:create, params: params)
        end.to create_record(User, name: "Test name")
      end.to fail_including("Record was created but attributes do not match")
    end
  end
end
