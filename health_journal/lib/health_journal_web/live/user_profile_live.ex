defmodule HealthJournalWeb.ProfileLive do
  use Phoenix.LiveView
  alias HealthJournal.Accounts
  alias HealthJournal.Accounts.UserProfile

  def mount(_params, _session, socket) do
    {:ok, assign(socket, profile: %UserProfile{})}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>User Profile</h1>
      <form phx-submit="save_profile">
        <div>
          <label for="height">Height (cm):</label>
          <input type="number" name="profile[height]" id="height" value={@profile.height}/>
        </div>
        <div>
          <label for="weight">Weight (kg):</label>
          <input type="number" name="profile[weight]" id="weight" value={@profile.weight}/>
        </div>
        <div>
          <label for="age">Age:</label>
          <input type="number" name="profile[age]" id="age" value={@profile.age}/>
        </div>
        <div>
          <label for="gender">Gender:</label>
          <select name="profile[gender]" id="gender" value={@profile.gender}>
            <option value="male">Male</option>
            <option value="female">Female</option>
          </select>
        </div>
        <div>
          <label for="fitness_level">Fitness Level:</label>
          <select name="profile[fitness_level]" id="fitness_level" value={@profile.fitness_level}>
            <option value="sedentary">Sedentary</option>
            <option value="lightly active">Lightly Active</option>
            <option value="moderately active">Moderately Active</option>
            <option value="very active">Very Active</option>
            <option value="super active">Super Active</option>
          </select>
        </div>
        <div>
          <label for="biceps">Biceps (cm):</label>
          <input type="number" name="profile[biceps]" id="biceps" value={@profile.biceps}/>
        </div>
        <div>
          <label for="forearms">Forearms (cm):</label>
          <input type="number" name="profile[forearms]" id="forearms" value={@profile.forearms}/>
        </div>
        <div>
          <label for="calves">Calves (cm):</label>
          <input type="number" name="profile[calves]" id="calves" value={@profile.calves}/>
        </div>
        <div>
          <label for="stomach">Stomach (cm):</label>
          <input type="number" name="profile[stomach]" id="stomach" value={@profile.stomach}/>
        </div>
        <div>
          <label for="chest">Chest (cm):</label>
          <input type="number" name="profile[chest]" id="chest" value={@profile.chest}/>
        </div>
        <div>
          <label for="waist">Waist (cm):</label>
          <input type="number" name="profile[waist]" id="waist" value={@profile.waist}/>
        </div>
        <div>
          <label for="hips">Hips (cm):</label>
          <input type="number" name="profile[hips]" id="hips" value={@profile.hips}/>
        </div>
        <div>
          <label for="thighs">Thighs (cm):</label>
          <input type="number" name="profile[thighs]" id="thighs" value={@profile.thighs}/>
        </div>
        <button type="submit">Save</button>
      </form>
      <div>
        <p>BMI: {@profile.bmi}</p>
        <p>TDEE: {@profile.tdee}</p>
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
