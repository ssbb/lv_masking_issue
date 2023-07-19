defmodule LiveViewMaskingExampleWeb.PoductLive.FormComponent do
  use LiveViewMaskingExampleWeb, :live_component

  alias LiveViewMaskingExample.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage poduct records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="poduct-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:title]} type="text" label="Title" phx-hook="FormatTest" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Poduct</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{poduct: poduct} = assigns, socket) do
    changeset = Catalog.change_poduct(poduct)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"poduct" => poduct_params}, socket) do
    changeset =
      socket.assigns.poduct
      |> Catalog.change_poduct(poduct_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"poduct" => poduct_params}, socket) do
    save_poduct(socket, socket.assigns.action, poduct_params)
  end

  defp save_poduct(socket, :edit, poduct_params) do
    case Catalog.update_poduct(socket.assigns.poduct, poduct_params) do
      {:ok, poduct} ->
        notify_parent({:saved, poduct})

        {:noreply,
         socket
         |> put_flash(:info, "Poduct updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_poduct(socket, :new, poduct_params) do
    case Catalog.create_poduct(poduct_params) do
      {:ok, poduct} ->
        notify_parent({:saved, poduct})

        {:noreply,
         socket
         |> put_flash(:info, "Poduct created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
