defmodule HealthJournalWeb.ProfileLive do
  use Phoenix.LiveView
  alias HealthJournal.Accounts
  alias HealthJournal.Accounts.UserProfile

  def mount(_params, _session, socket) do
    {:ok, assign(socket, profile: %UserProfile{})}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto p-6 bg-white shadow-md rounded-md">
      <h1 class="text-2xl font-semibold mb-4">User Profile</h1>
      <form phx-submit="save_profile" class="space-y-4">
        <div>
          <label for="height" class="block text-sm font-medium text-gray-700">Height (cm):</label>
          <input type="number" name="profile[height]" id="height" value={@profile.height} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="weight" class="block text-sm font-medium text-gray-700">Weight (kg):</label>
          <input type="number" name="profile[weight]" id="weight" value={@profile.weight} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="age" class="block text-sm font-medium text-gray-700">Age:</label>
          <input type="number" name="profile[age]" id="age" value={@profile.age} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="gender" class="block text-sm font-medium text-gray-700">Gender:</label>
          <select name="profile[gender]" id="gender" value={@profile.gender} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            <option value="male">Male</option>
            <option value="female">Female</option>
          </select>
        </div>
        <div>
          <label for="fitness_level" class="block text-sm font-medium text-gray-700">Fitness Level:</label>
          <select name="profile[fitness_level]" id="fitness_level" value={@profile.fitness_level} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            <option value="sedentary">Sedentary</option>
            <option value="lightly active">Lightly Active</option>
            <option value="moderately active">Moderately Active</option>
            <option value="very active">Very Active</option>
            <option value="super active">Super Active</option>
          </select>
        </div>
        <div>
          <label for="biceps" class="block text-sm font-medium text-gray-700">Biceps (cm):</label>
          <input type="number" name="profile[biceps]" id="biceps" value={@profile.biceps} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="forearms" class="block text-sm font-medium text-gray-700">Forearms (cm):</label>
          <input type="number" name="profile[forearms]" id="forearms" value={@profile.forearms} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="calves" class="block text-sm font-medium text-gray-700">Calves (cm):</label>
          <input type="number" name="profile[calves]" id="calves" value={@profile.calves} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="stomach" class="block text-sm font-medium text-gray-700">Stomach (cm):</label>
          <input type="number" name="profile[stomach]" id="stomach" value={@profile.stomach} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="chest" class="block text-sm font-medium text-gray-700">Chest (cm):</label>
          <input type="number" name="profile[chest]" id="chest" value={@profile.chest} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="waist" class="block text-sm font-medium text-gray-700">Waist (cm):</label>
          <input type="number" name="profile[waist]" id="waist" value={@profile.waist} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="hips" class="block text-sm font-medium text-gray-700">Hips (cm):</label>
          <input type="number" name="profile[hips]" id="hips" value={@profile.hips} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <div>
          <label for="thighs" class="block text-sm font-medium text-gray-700">Thighs (cm):</label>
          <input type="number" name="profile[thighs]" id="thighs" value={@profile.thighs} class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
        </div>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md shadow-sm hover:bg-blue-700">Save</button>
      </form>
      <div class="mt-6">
        <p class="text-lg">BMI: {@profile.bmi}</p>
        <p class="text-lg">TDEE: {@profile.tdee}</p>
      </div>
    </div>
    """
  end

  def handle_event("save_profile", %{"profile" => profile_params}, socket) do
    case Accounts.create_user_profile(profile_params) do
      {:ok, profile} ->
        {:noreply, assign(socket, profile: profile)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
