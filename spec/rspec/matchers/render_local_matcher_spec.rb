require "spec_helper"
require "support/controller_specs_boilerplate"

describe "render_local matcher", type: :controller do
  context "controller render local with simple value" do
    controller do
      append_view_path("spec/fixtures/views")

      def index
        render :index, locals: { example_local_name: 10 }
      end
    end

    it "ensures that a local with given value was passed to render" do
      expect { get :index }.to render_local(example_local_name: 10)
    end

    it "ensures that a local with given value was not passed to render" do
      expect { get :index }.to_not render_local(example_local_name: 11)
    end
  end

  context "controller render local with object of given class" do
    controller do
      append_view_path("spec/fixtures/views")

      class DummyClass; end
      class AnotherDummyClass; end

      def index
        render :index, locals: { example_local_name: DummyClass.new }
      end
    end

    it "ensures that a local with given object was passed to render" do
      expect { get :index }.to render_local(:example_local_name, DummyClass)
    end

    it "ensures that a local with given object as not passed to render" do
      expect { get :index }.to_not render_local(:example_local_name, AnotherDummyClass)
    end

    context "local name matches snake-cased klass name" do
      controller do
        append_view_path("spec/fixtures/views")

        class DummyClass; end
        class AnotherDummyClass; end

        def index
          render :index, locals: { dummy_class: DummyClass.new }
        end
      end

      it "ensures that a local with given object was passed to render" do
        expect { get :index }.to render_local(DummyClass)
      end

      it "ensures that a local with given object as not passed to render" do
        expect { get :index }.to_not render_local(AnotherDummyClass)
      end
    end

    context "local name does not match snake-cased klass name" do
      controller do
        append_view_path("spec/fixtures/views")

        class DummyClass; end

        def index
          render :index, locals: { dummy_nice_class: DummyClass.new }
        end
      end

      it "ensures that a local with given object was passed to render" do
        expect { get :index }.to_not render_local(DummyClass)
      end
    end
  end
end
