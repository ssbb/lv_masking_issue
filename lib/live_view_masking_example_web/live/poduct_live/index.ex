defmodule LiveViewMaskingExampleWeb.PoductLive.Index do
  use LiveViewMaskingExampleWeb, :live_view

  alias LiveViewMaskingExample.Catalog
  alias LiveViewMaskingExample.Catalog.Poduct

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :products, Catalog.list_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Poduct")
    |> assign(:poduct, Catalog.get_poduct!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Poduct")
    |> assign(:poduct, %Poduct{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:poduct, nil)
  end

  @impl true
  def handle_info({LiveViewMaskingExampleWeb.PoductLive.FormComponent, {:saved, poduct}}, socket) do
    {:noreply, stream_insert(socket, :products, poduct)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    poduct = Catalog.get_poduct!(id)
    {:ok, _} = Catalog.delete_poduct(poduct)

    {:noreply, stream_delete(socket, :products, poduct)}
  end
end
