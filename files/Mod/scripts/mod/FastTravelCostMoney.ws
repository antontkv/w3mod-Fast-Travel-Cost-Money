class FastTravelCostMoney
{
	public var mapMenuRef : CR4MapMenu;
	protected var fastTravelCostMoneyPopup : FastTravelCostMoneyConfPopup;
    private var fastTravelCost : int;
	
	public function Init(pinTag : name, areaId : int)
	{
        fastTravelCost = 100;
        fastTravelCost = (thePlayer.GetLevel() / 10 + 1) * fastTravelCost;

        if ( thePlayer.GetMoney() < fastTravelCost )
        {
            mapMenuRef.showNotification(GetLocStringByKeyExt("fast_travel_cost_money_no_money") + " " + IntToString(fastTravelCost));
            theSound.SoundEvent("gui_global_denied");
            return;
        }

        fastTravelCostMoneyPopup = new FastTravelCostMoneyConfPopup in this;
        fastTravelCostMoneyPopup.fastTravelCost = fastTravelCost;
        fastTravelCostMoneyPopup.pinTag = pinTag;
        fastTravelCostMoneyPopup.areaId = areaId;
        fastTravelCostMoneyPopup.mapMenuRef = mapMenuRef;
        fastTravelCostMoneyPopup.SetMessageText(GetLocStringByKeyExt("fast_travel_cost_money_popup_message") + " " + IntToString(fastTravelCost));
        fastTravelCostMoneyPopup.BlurBackground;
        
        mapMenuRef.RequestSubMenu('PopupMenu', fastTravelCostMoneyPopup);
	}
}

class FastTravelCostMoneyConfPopup extends ConfirmationPopupData
{
    public var pinTag : name;
    public var areaId : int;
    public var fastTravelCost : int;
	public var mapMenuRef : CR4MapMenu;
	
	protected function OnUserAccept() : void
	{
        thePlayer.RemoveMoney(fastTravelCost); 
        theSound.SoundEvent("gui_inventory_buy");
        mapMenuRef.FastTravel(pinTag, areaId);
	}
}