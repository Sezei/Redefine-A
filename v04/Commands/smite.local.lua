local l = game:GetService("Lighting")
local ev = 3

script.lightning_bolt.PlaybackSpeed = math.random(1,3)
script.lightning_bolt:Play()

while wait() do
	if ev >= 0 then
		ev = ev-0.15
		l.ExposureCompensation = ev
		wait(0.1)
	else
		ev = 0
		l.ExposureCompensation = ev
		script:Destroy()
		break
	end
end