defmodule LiveViewMaskingExampleWeb.PoductLive.Show do
  use LiveViewMaskingExampleWeb, :live_view

  alias LiveViewMaskingExample.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:poduct, Catalog.get_poduct!(id))}
  end

  defp page_title(:show), do: "Show Poduct"
  defp page_title(:edit), do: "Edit Poduct"
end
