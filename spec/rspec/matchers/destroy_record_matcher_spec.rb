require "spec_helper"
require "support/controller_specs_boilerplate"
require "rspec/matchers/fail_matchers"

class User < ActiveRecord::Base
end



describe "destroy_record matcher", type: :controller do
  context "controller destroys record" do
    controller do
      def destroy
        User.find(params[:id]).destroy
      end
    end

    it "ensures that record is destroyed" do
      user = User.create

      expect { delete :destroy, params: { id: user.id } }.
        to destroy_record(user)
    end
  end

  context "service object destroys record" do
    class DestroyUser
      def self.call(id)
        User.find(id).destroy
      end
    end

    controller do
      def destroy
        DestroyUser.call(params[:id])
      end
    end

    it "ensures that record is destroyed by service object" do
      user = User.create

      expect { delete :destroy, params: { id: user.id } }.
        to destroy_record(user).using(DestroyUser)
    end
  end

  context "service object does not destroys record but controller does" do
    class DestroyUser
      def self.call(id)
      end
    end

    controller do
      def destroy
        DestroyUser.call(params[:id])
        User.find(params[:id]).destroy
      end
    end

    it "ensures that record is destroyed by service object" do
      user = User.create

      expect do
        expect { delete :destroy, params: { id: user.id } }.
          to destroy_record(user).using(DestroyUser)
      end.to fail_with("Expected a record of User class to be destroyed using DestroyUser service class, but was destroyed using controller")
    end
  end

  context "controller does not destroy" do
    controller do
      def destroy
      end
    end

    it "ensures that record is not destroyed" do
      user = User.create

      expect do
        expect do
          delete(:destroy, params: { id: user.id })
        end.to destroy_record(user)
      end.to fail_with("Expected a record of User class to be destroyed, but was not")
    end
  end
end
