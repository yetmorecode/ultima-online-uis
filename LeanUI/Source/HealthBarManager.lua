----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HealthBarManager = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

HealthBarManager.partyMemberIndex = {}

HealthBarManager.MAX_PARTY_MEMBERS = 10

HealthBarManager.SpellSchools = { MAGERY = 25, CHIVALRY = 51 }
HealthBarManager.UseSchool = HealthBarManager.SpellSchools.MAGERY

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function HealthBarManager.Initialize()
	RegisterWindowData(WindowData.PartyMember.Type,0)
	
	WindowRegisterEventHandler( "Root", SystemData.Events.BEGIN_DRAG_HEALTHBAR_WINDOW, "HealthBarManager.OnBeginDragHealthBar")
	WindowRegisterEventHandler( "Root", SystemData.Events.END_DRAG_HEALTHBAR_WINDOW, "HealthBarManager.OnEndDragHealthBar")
	WindowRegisterEventHandler( "Root", WindowData.PartyMember.Event, "HealthBarManager.HandlePartyMemberUpdate")
	WindowRegisterEventHandler( "Root", WindowData.SkillDynamicData.Event, "HealthBarManager.SkillUpdate")
	
	for i = 1, HealthBarManager.MAX_PARTY_MEMBERS do
		HealthBarManager.partyMemberIndex[i] = 0
		
		if (i <= WindowData.PartyMember.NUM_PARTY_MEMBERS) then
			HealthBarManager.partyMemberIndex[i] = WindowData.PartyMember[i].memberId
		end
	end
	
	HealthBarManager.HandlePartyMemberUpdate()
	HealthBarManager.SkillUpdate()
end

function HealthBarManager.OnBeginDragHealthBar(id)
	local mobileId = SystemData.ActiveMobile.Id
	
	if id ~= nil then
		mobileId = id
	end
	
	WindowUtils.BeginDrag(MobileHealthBar.CreateHealthBar, mobileId)
end

function HealthBarManager.OnEndDragHealthBar()
	WindowUtils.EndDrag()
end

function HealthBarManager.HandlePartyMemberUpdate()
	for i = HealthBarManager.MAX_PARTY_MEMBERS, 1, -1 do
		if i <= WindowData.PartyMember.NUM_PARTY_MEMBERS then
			HealthBarManager.partyMemberIndex[i] = WindowData.PartyMember[i].memberId
			local mobileId = HealthBarManager.partyMemberIndex[i]
			
			if not MobileHealthBar.HasWindow(mobileId) then
				MobileHealthBar.CreateHealthBar(mobileId, true)
			end
		else
			HealthBarManager.partyMemberIndex[i] = 0
		end
	end
end

function HealthBarManager.IsPartyMember(mobileId)
	for i = 1, WindowData.PartyMember.NUM_PARTY_MEMBERS do
		local currentPartyMemberId = WindowData.PartyMember[i].memberId
    	if (currentPartyMemberId == mobileId) then
    		return true
		end
    end
	
	return false
end

function HealthBarManager.GetMemberIndex(mobileId)
	for i = 1, HealthBarManager.MAX_PARTY_MEMBERS do
    	if (HealthBarManager.partyMemberIndex[i] == mobileId) then
    		return i
		end
    end
    
    return 0
end

function HealthBarManager.SkillUpdate()

end