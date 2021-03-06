defmodule RateCoffee.Dataloader do
  defmacro __using__([]) do
    quote do
      def data() do
        Dataloader.Ecto.new(RateCoffee.Repo, query: &query/2)
      end

      def query(queryable, _params) do
        queryable
      end
    end
  end
end
