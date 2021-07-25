local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Exunys Developer";
        Text = "Boxes script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Typing = false

_G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the 2D boxes script would run with default settings regardless of any changes you made.

_G.TeamCheck = false   -- If set to true then the script would create 2D boxes only for the enemy team members.

_G.SquaresVisible = true   -- If set to true then the 2D boxes will be visible and vice versa.
_G.SquareColor = Color3.fromRGB(255, 80, 10)   -- The color that the 2D boxes would appear as.
_G.SquareThickness = 1   -- The thickness of the 2D boxes.
_G.SquareFilled = false   -- If set to true then the squares would be filled and vice versa.
_G.SquareTransparency = 0.7   -- The transparency of the 2D boxes / squares.

--// Don't touch, needed for the correct size of the square.

_G.HeadOffset = Vector3.new(0, 0.5, 0)
_G.LegsOffset = Vector3.new(0, 3, 0)

_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the 2D boxes.

local function CreateSquares()
	for _, v in next, Players:GetPlayers() do
		if v ~= LocalPlayer then
			if v.Character ~= nil then
				if v.Character:WaitForChild("HumanoidRootPart", math.huge) ~= nil then
					if v.Character:WaitForChild("Humanoid", math.huge) ~= nil and v.Character:WaitForChild("Humanoid", math.huge).Health > 0 then
						local Square = Drawing.new("Square")
						Square.Thickness = _G.SquareThickness
						Square.Transparency = _G.SquareTransparency
						Square.Color = _G.SquareColor
						Square.Filled = _G.SquareFilled

						RunService.RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character.HumanoidRootPart ~= nil then
								local Victim_HumanoidRootPart, OnScreen = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local Victim_Head = Camera:WorldToViewportPoint(v.Character:WaitForChild("Head", math.huge).Position + _G.HeadOffset)
								local Victim_Legs = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position - _G.LegsOffset)

								if OnScreen == true and _G.SquaresVisible == true then
									Square.Size = Vector2.new(2000 / Victim_HumanoidRootPart.Z, Victim_Head.Y - Victim_Legs.Y)
									Square.Position = Vector2.new(Victim_HumanoidRootPart.X - Square.Size.X / 2, Victim_HumanoidRootPart.Y - Square.Size.Y / 2)

									Square.Thickness = _G.SquareThickness
									Square.Transparency = _G.SquareTransparency
									Square.Color = _G.SquareColor
									Square.Filled = _G.SquareFilled

									if _G.TeamCheck == true then
										if v.Team ~= LocalPlayer.Team then
											Square.Visible = true
										else
											Square.Visible = false
										end
									else
										Square.Visible = true
									end
								else
									Square.Visible = false
								end
							else
								Square.Visible = false
							end
						end)

						Players.PlayerRemoving:Connect(function(Player)
							if Player == v then
								Square.Visible = false
							end
						end)
					end
 				end
			end
		end
	end

	Players.PlayerAdded:Connect(function(v)
		repeat wait() until v.Character

		if v ~= LocalPlayer then
			if v.Character ~= nil then
				if v.Character:WaitForChild("HumanoidRootPart", math.huge) ~= nil then
					if v.Character:WaitForChild("Humanoid", math.huge) ~= nil and v.Character:WaitForChild("Humanoid", math.huge).Health > 0 then
						local Square = Drawing.new("Square")
						Square.Thickness = _G.SquareThickness
						Square.Transparency = _G.SquareTransparency
						Square.Color = _G.SquareColor
						Square.Filled = _G.SquareFilled

						RunService.RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character.HumanoidRootPart ~= nil then
								local Victim_HumanoidRootPart, OnScreen = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local Victim_Head = Camera:WorldToViewportPoint(v.Character:WaitForChild("Head", math.huge).Position + _G.HeadOffset)
								local Victim_Legs = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position - _G.LegsOffset)

								if OnScreen == true and _G.SquaresVisible == true then
									Square.Size = Vector2.new(2000 / Victim_HumanoidRootPart.Z, Victim_Head.Y - Victim_Legs.Y)
									Square.Position = Vector2.new(Victim_HumanoidRootPart.X - Square.Size.X / 2, Victim_HumanoidRootPart.Y - Square.Size.Y / 2)

									Square.Thickness = _G.SquareThickness
									Square.Transparency = _G.SquareTransparency
									Square.Color = _G.SquareColor
									Square.Filled = _G.SquareFilled

									if _G.TeamCheck == true then
										if v.Team ~= LocalPlayer.Team then
											Square.Visible = true
										else
											Square.Visible = false
										end
									else
										Square.Visible = true
									end
								else
									Square.Visible = false
								end
							else
								Square.Visible = false
							end
						end)

						Players.PlayerRemoving:Connect(function(Player)
							if Player == v then
								Square.Visible = false
							end
						end)
					end
				end
			end
		end
	end)
end

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.SquaresVisible = true
    _G.SquareColor = Color3.fromRGB(40, 90, 255)
    _G.SquareThickness = 2
	_G.SquareFilled = false
    _G.SquareTransparency = 0.5
    _G.DisableKey = Enum.KeyCode.Q
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.SquaresVisible = not _G.SquaresVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Exunys Developer";
                Text = "The 2D boxes' visibility is now set to "..tostring(_G.SquaresVisible)..".";
                Duration = 5;
            })
        end
    end
end)

local Success, Errored = pcall(function()
    CreateSquares()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "2D Boxes script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "2D Boxes script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
    TestService:Message("The boxes script has errored, please notify Exunys with the following information :")
    warn(Errored)
    print("!! IF THE ERROR IS A FALSE POSITIVE (says that a player cannot be found) THEN DO NOT BOTHER !!")
end
