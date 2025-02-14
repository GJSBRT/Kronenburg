﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Bones = {
    [0] = { name = "SKEL_ROOT", label = "Onbekend (ergens in lichaam)" },
    [11816] = { name = "SKEL_Pelvis", label = "Bekken" },
    [58271] = { name = "SKEL_L_Thigh", label = "L. Bovenbeen" },
    [63931] = { name = "SKEL_L_Calf", label = "L. Onderbeen" },
    [14201] = { name = "SKEL_L_Foot", label = "L. Voet" },
    [2108] = { name = "SKEL_L_Toe0", label = "L. Teen" },
    [33989] = { name = "EO_L_Foot" },
    [26813] = { name = "EO_L_Toe" },
    [65245] = { name = "IK_L_Foot" },
    [57717] = { name = "PH_L_Foot" },
    [46078] = { name = "MH_L_Knee" },
    [51826] = { name = "SKEL_R_Thigh", label = "R. Bovenbeen" },
    [36864] = { name = "SKEL_R_Calf", label = "R. Onderbeen" },
    [52301] = { name = "SKEL_R_Foot", label = "R. Voet" },
    [20781] = { name = "SKEL_R_Toe0", label = "R. Teen" },
    [4246] = { name = "EO_R_Foot" },
    [29027] = { name = "EO_R_Toe" },
    [35502] = { name = "IK_R_Foot" },
    [24806] = { name = "PH_R_Foot" },
    [16335] = { name = "MH_R_Knee" },
    [23639] = { name = "RB_L_ThighRoll" },
    [6442] = { name = "RB_R_ThighRoll" },
    [57597] = { name = "SKEL_Spine_Root" },
    [23553] = { name = "SKEL_Spine0" },
    [24816] = { name = "SKEL_Spine1" },
    [24817] = { name = "SKEL_Spine2" },
    [24818] = { name = "SKEL_Spine3" },
    [64729] = { name = "SKEL_L_Clavicle", label = "L. Sleutelbeen" },
    [45509] = { name = "SKEL_L_UpperArm", label = "L. Bovenarm" },
    [61163] = { name = "SKEL_L_Forearm", label = "L. Onderarm" },
    [18905] = { name = "SKEL_L_Hand", label = "L. Hand" },
    [26610] = { name = "SKEL_L_Finger00" },
    [4089] = { name = "SKEL_L_Finger01" },
    [4090] = { name = "SKEL_L_Finger02" },
    [26611] = { name = "SKEL_L_Finger10" },
    [4169] = { name = "SKEL_L_Finger11" }, -- SKEL_L_Finger11 = 0x1049,
    [4170] = { name = "SKEL_L_Finger12" }, -- SKEL_L_Finger12 = 0x104A,
    [26612] =  { name = "SKEL_L_Finger20" },
    [4185] = { name = "SKEL_L_FINGER21" }, -- SKEL_L_Finger21 = 0x1059,
    [4186] = { name = "SKEL_L_Finger22" }, -- SKEL_L_Finger22 = 0x105A,
    [26613] = { name = "SKEL_L_Finger30" }, -- SKEL_L_Finger30 = 0x67F5,
    [4137] = { name = "SKEL_L_Finger31" }, -- SKEL_L_Finger31 = 0x1029,
    [4138] = { name = "SKEL_L_Finger32" }, -- SKEL_L_Finger32 = 0x102A,
    [26614] = { name = "SKEL_L_Finger40" }, -- SKEL_L_Finger40 = 0x67F6,
    [4153] = { name = "SKEL_L_Finger41" }, -- SKEL_L_Finger41 = 0x1039,
    [4154] = { name = "SKEL_L_Finger42" }, -- SKEL_L_Finger42 = 0x103A,
    [60309] = { name = "PH_L_Hand" },
    [36029] = { name = "IK_L_Hand" },
    [61007] = { name = "RB_L_ForeArmRoll" },
    [5232] = { name = "RB_L_ArmRoll" },
    [22711] = { name = "MH_L_Elbow" },
    [10706] = { name = "SKEL_R_Clavicle", label = "R. Sleutelbeen" },
    [40269] = { name = "SKEL_R_UpperArm", label = "R. Bovenarm" },
    [28252] = { name = "SKEL_R_Forearm", label = "R. Onderarm" },
    [57005] = { name = "SKEL_R_Hand", label = "R. Hand" },
    [58866] = { name = "SKEL_R_Finger00" },
    [64016] = { name = "SKEL_R_Finger01" },
    [64017] = { name = "SKEL_R_Finger02" },
    [58867] = { name = "SKEL_R_Finger10" },
    [64096] = { name = "SKEL_R_Finger11" }, -- SKEL_R_Finger11 = 0xFA60,
    [64097] = { name = "SKEL_R_Finger12" }, -- SKEL_R_Finger12 = 0xFA61,
    [58868] = { name = "SKEL_R_Finger20" }, -- SKEL_R_Finger20 = 0xE5F4,
    [64112] = { name = "SKEL_R_Finger21" }, -- SKEL_R_Finger21 = 0xFA70,
    [64113] = { name = "SKEL_R_Finger22" }, -- SKEL_R_Finger22 = 0xFA71,
    [58869] = { name = "SKEL_R_Finger30" }, -- SKEL_R_Finger30 = 0xE5F5,
    [64064] = { name = "SKEL_R_Finger31" }, -- SKEL_R_Finger31 = 0xFA40,
    [64065] = { name = "SKEL_R_Finger32" }, -- SKEL_R_Finger32 = 0xFA41,
    [58870] = { name = "SKEL_R_Finger40" }, -- SKEL_R_Finger40 = 0xE5F6,
    [64080] = { name = "SKEL_R_Finger41" }, -- SKEL_R_Finger41 = 0xFA50,
    [64081] = { name = "SKEL_R_Finger42" },-- SKEL_R_Finger42 = 0xFA51,
    [28422] =  { name = "PH_R_Hand" },
    [6286] =  { name = "IK_R_Hand" },
    [43810] =  { name = "RB_R_ForeArmRoll" },
    [37119] =  { name = "RB_R_ArmRoll" },
    [2992] =  { name = "MH_R_Elbow" },
    [39317] =  { name = "SKEL_Neck_1" },
    [31086] =  { name = "SKEL_Head" },
    [12884] =  { name = "IK_Head" },
    [65068] =  { name = "FACIAL_facialRoot" },
    -- FB_L_Brow_Out_000 = 0xE3DB,
    -- FB_L_Lid_Upper_000 = 0xB2B6,
    [25260] =  { name = "FB_L_Eye_000" },
    [21550] =  { name = "FB_L_CheekBone_000" },
    -- FB_L_Lip_Corner_000 = 0x74AC,
    -- FB_R_Lid_Upper_000 = 0xAA10,
    [27474] =  { name = "FB_R_Eye_000" },
    [19336] =  { name = "FB_R_CheekBone_000" },
    -- FB_R_Brow_Out_000 = 0x54C,
    -- FB_R_Lip_Corner_000 = 0x2BA6,
    -- FB_Brow_Centre_000 = 0x9149,
    -- FB_UpperLipRoot_000 = 0x4ED2,
    -- FB_UpperLip_000 = 0xF18F,
    -- FB_L_Lip_Top_000 = 0x4F37,
    -- FB_R_Lip_Top_000 = 0x4537,
    -- FB_Jaw_000 = 0xB4A0,
    -- FB_LowerLipRoot_000 = 0x4324,
    -- FB_LowerLip_000 = 0x508F,
    -- FB_L_Lip_Bot_000 = 0xB93B,
    -- FB_R_Lip_Bot_000 = 0xC33B,
    -- FB_Tongue_000 = 0xB987,
    [35731] =  { name = "RB_Neck_1" },
    [64654] =  { name = "SPR_L_Breast" },
    [34911] =  { name = "SPR_R_Breast" },
    [56604] =  { name = "IK_Root" },
    [24532] =  { name = "SKEL_Neck_2" },
    [53251] =  { name = "SKEL_Pelvis1" },
    [17916] =  { name = "SKEL_PelvisRoot" },
    [38180] =  { name = "SKEL_SADDLE" },
    -- MH_L_CalfBack = 0x1013,
    -- MH_L_ThighBack = 0x600D,
    -- SM_L_Skirt = 0xC419,
    -- MH_R_CalfBack = 0xB013,
    -- MH_R_ThighBack = 0x51A3,
    -- SM_R_Skirt = 0x7712,
    [3515] =  { name = "SM_M_BackSkirtRoll" },
    -- SM_L_BackSkirtRoll = 0x40B2,
    -- SM_R_BackSkirtRoll = 0xC141,
    -- SM_M_FrontSkirtRoll = 0xCDBB,
    -- SM_L_FrontSkirtRoll = 0x9B69,
    -- SM_R_FrontSkirtRoll = 0x86F1,
    [50813] =  { name = "SM_CockNBalls_ROOT" },
    [40244] =  { name = "SM_CockNBalls" },
    [35939] =  { name = "MH_L_Finger00" },
    [24504] =  { name = "MH_L_FingerBulge00" },
    [35923] =  { name = "MH_L_Finger10" },
    [41540] =  { name = "MH_L_FingerTop00" },
    -- MH_L_HandSide = 0xC78A,
    [10040] =  { name = "MH_Watch" },
    -- MH_L_Sleeve = 0x933C,
    -- MH_R_Finger00 = 0x2C63,
    -- MH_R_FingerBulge00 = 0x69B8,
    -- MH_R_Finger10 = 0x2C53,
    -- MH_R_FingerTop00 = 0xEF4B,
    -- MH_R_HandSide = 0x68FB,
    -- MH_R_Sleeve = 0x92DC,
    [2849] =  { name = "FACIAL_jaw" },
    [35477] =  { name = "FACIAL_underChin" },
    [9038] =  { name = "FACIAL_L_underChin" },
    [46456] =  { name = "FACIAL_chin" },
    -- FACIAL_chinSkinBottom = 0x98BC,
    -- FACIAL_L_chinSkinBottom = 0x3E8F,
    -- FACIAL_R_chinSkinBottom = 0x9E8F,
    -- FACIAL_tongueA = 0x4A7C,
    -- FACIAL_tongueB = 0x4A7D,
    -- FACIAL_tongueC = 0x4A7E,
    -- FACIAL_tongueD = 0x4A7F,
    -- FACIAL_tongueE = 0x4A80,
    -- FACIAL_L_tongueE = 0x35F2,
    -- FACIAL_R_tongueE = 0x2FF2,
    -- FACIAL_L_tongueD = 0x35F1,
    -- FACIAL_R_tongueD = 0x2FF1,
    -- FACIAL_L_tongueC = 0x35F0,
    -- FACIAL_R_tongueC = 0x2FF0,
    -- FACIAL_L_tongueB = 0x35EF,
    -- FACIAL_R_tongueB = 0x2FEF,
    -- FACIAL_L_tongueA = 0x35EE,
    -- FACIAL_R_tongueA = 0x2FEE,
    -- FACIAL_chinSkinTop = 0x7226,
    -- FACIAL_L_chinSkinTop = 0x3EB3,
    -- FACIAL_chinSkinMid = 0x899A,
    -- FACIAL_L_chinSkinMid = 0x4427,
    -- FACIAL_L_chinSide = 0x4A5E,
    -- FACIAL_R_chinSkinMid = 0xF5AF,
    -- FACIAL_R_chinSkinTop = 0xF03B,
    -- FACIAL_R_chinSide = 0xAA5E,
    -- FACIAL_R_underChin = 0x2BF4,
    -- FACIAL_L_lipLowerSDK = 0xB9E1,
    -- FACIAL_L_lipLowerAnalog = 0x244A,
    -- FACIAL_L_lipLowerThicknessV = 0xC749,
    -- FACIAL_L_lipLowerThicknessH = 0xC67B,
    -- FACIAL_lipLowerSDK = 0x7285,
    -- FACIAL_lipLowerAnalog = 0xD97B,
    -- FACIAL_lipLowerThicknessV = 0xC5BB,
    -- FACIAL_lipLowerThicknessH = 0xC5ED,
    -- FACIAL_R_lipLowerSDK = 0xA034,
    -- FACIAL_R_lipLowerAnalog = 0xC2D9,
    -- FACIAL_R_lipLowerThicknessV = 0xC6E9,
    -- FACIAL_R_lipLowerThicknessH = 0xC6DB,
    -- FACIAL_nose = 0x20F1,
    -- FACIAL_L_nostril = 0x7322,
    -- FACIAL_L_nostrilThickness = 0xC15F,
    -- FACIAL_noseLower = 0xE05A,
    -- FACIAL_L_noseLowerThickness = 0x79D5,
    -- FACIAL_R_noseLowerThickness = 0x7975,
    -- FACIAL_noseTip = 0x6A60,
    -- FACIAL_R_nostril = 0x7922,
    -- FACIAL_R_nostrilThickness = 0x36FF,
    -- FACIAL_noseUpper = 0xA04F,
    -- FACIAL_L_noseUpper = 0x1FB8,
    -- FACIAL_noseBridge = 0x9BA3,
    -- FACIAL_L_nasolabialFurrow = 0x5ACA,
    -- FACIAL_L_nasolabialBulge = 0xCD78,
    -- FACIAL_L_cheekLower = 0x6907,
    -- FACIAL_L_cheekLowerBulge1 = 0xE3FB,
    -- FACIAL_L_cheekLowerBulge2 = 0xE3FC,
    -- FACIAL_L_cheekInner = 0xE7AB,
    -- FACIAL_L_cheekOuter = 0x8161,
    -- FACIAL_L_eyesackLower = 0x771B,
    -- FACIAL_L_eyeball = 0x1744,
    -- FACIAL_L_eyelidLower = 0x998C,
    -- FACIAL_L_eyelidLowerOuterSDK = 0xFE4C,
    -- FACIAL_L_eyelidLowerOuterAnalog = 0xB9AA,
    -- FACIAL_L_eyelashLowerOuter = 0xD7F6,
    -- FACIAL_L_eyelidLowerInnerSDK = 0xF151,
    -- FACIAL_L_eyelidLowerInnerAnalog = 0x8242,
    -- FACIAL_L_eyelashLowerInner = 0x4CCF,
    -- FACIAL_L_eyelidUpper = 0x97C1,
    -- FACIAL_L_eyelidUpperOuterSDK = 0xAF15,
    -- FACIAL_L_eyelidUpperOuterAnalog = 0x67FA,
    -- FACIAL_L_eyelashUpperOuter = 0x27B7,
    -- FACIAL_L_eyelidUpperInnerSDK = 0xD341,
    -- FACIAL_L_eyelidUpperInnerAnalog = 0xF092,
    -- FACIAL_L_eyelashUpperInner = 0x9B1F,
    -- FACIAL_L_eyesackUpperOuterBulge = 0xA559,
    -- FACIAL_L_eyesackUpperInnerBulge = 0x2F2A,
    -- FACIAL_L_eyesackUpperOuterFurrow = 0xC597,
    -- FACIAL_L_eyesackUpperInnerFurrow = 0x52A7,
    [37400] =  { name = "FACIAL_forehead" },
    -- FACIAL_L_foreheadInner = 0x843,
    -- FACIAL_L_foreheadInnerBulge = 0x767C,
    -- FACIAL_L_foreheadOuter = 0x8DCB,
    [16929] =  { name = "FACIAL_skull" },
    -- FACIAL_foreheadUpper = 0xF7D6,
    -- FACIAL_L_foreheadUpperInner = 0xCF13,
    -- FACIAL_L_foreheadUpperOuter = 0x509B,
    -- FACIAL_R_foreheadUpperInner = 0xCEF3,
    -- FACIAL_R_foreheadUpperOuter = 0x507B,
    [44912] =  { name = "FACIAL_L_temple" },
    -- FACIAL_L_ear = 0x19DD,
    -- FACIAL_L_earLower = 0x6031,
    -- FACIAL_L_masseter = 0x2810,
    -- FACIAL_L_jawRecess = 0x9C7A,
    -- FACIAL_L_cheekOuterSkin = 0x14A5,
    -- FACIAL_R_cheekLower = 0xF367,
    -- FACIAL_R_cheekLowerBulge1 = 0x599B,
    -- FACIAL_R_cheekLowerBulge2 = 0x599C,
    -- FACIAL_R_masseter = 0x810,
    -- FACIAL_R_jawRecess = 0x93D4,
    -- FACIAL_R_ear = 0x1137,
    -- FACIAL_R_earLower = 0x8031,
    -- FACIAL_R_eyesackLower = 0x777B,
    -- FACIAL_R_nasolabialBulge = 0xD61E,
    -- FACIAL_R_cheekOuter = 0xD32,
    -- FACIAL_R_cheekInner = 0x737C,
    [7382] =  { name = "FACIAL_R_noseUpper" },
    -- FACIAL_R_foreheadInner = 0xE43,
    -- FACIAL_R_foreheadInnerBulge = 0x769C,
    -- FACIAL_R_foreheadOuter = 0x8FCB,
    -- FACIAL_R_cheekOuterSkin = 0xB334,
    -- FACIAL_R_eyesackUpperInnerFurrow = 0x9FAE,
    -- FACIAL_R_eyesackUpperOuterFurrow = 0x140F,
    -- FACIAL_R_eyesackUpperInnerBulge = 0xA359,
    -- FACIAL_R_eyesackUpperOuterBulge = 0x1AF9,
    -- FACIAL_R_nasolabialFurrow = 0x2CAA,
    [44825] =  { name = "FACIAL_R_temple" },
    -- FACIAL_R_eyeball = 0x1944,
    -- FACIAL_R_eyelidUpper = 0x7E14,
    -- FACIAL_R_eyelidUpperOuterSDK = 0xB115,
    -- FACIAL_R_eyelidUpperOuterAnalog = 0xF25A,
    -- FACIAL_R_eyelashUpperOuter = 0xE0A,
    -- FACIAL_R_eyelidUpperInnerSDK = 0xD541,
    -- FACIAL_R_eyelidUpperInnerAnalog = 0x7C63,
    -- FACIAL_R_eyelashUpperInner = 0x8172,
    -- FACIAL_R_eyelidLower = 0x7FDF,
    -- FACIAL_R_eyelidLowerOuterSDK = 0x1BD,
    -- FACIAL_R_eyelidLowerOuterAnalog = 0x457B,
    -- FACIAL_R_eyelashLowerOuter = 0xBE49,
    -- FACIAL_R_eyelidLowerInnerSDK = 0xF351,
    -- FACIAL_R_eyelidLowerInnerAnalog = 0xE13,
    -- FACIAL_R_eyelashLowerInner = 0x3322,
    -- FACIAL_L_lipUpperSDK = 0x8F30,
    -- FACIAL_L_lipUpperAnalog = 0xB1CF,
    -- FACIAL_L_lipUpperThicknessH = 0x37CE,
    -- FACIAL_L_lipUpperThicknessV = 0x38BC,
    -- FACIAL_lipUpperSDK = 0x1774,
    -- FACIAL_lipUpperAnalog = 0xE064,
    -- FACIAL_lipUpperThicknessH = 0x7993,
    -- FACIAL_lipUpperThicknessV = 0x7981,
    -- FACIAL_L_lipCornerSDK = 0xB1C,
    -- FACIAL_L_lipCornerAnalog = 0xE568,
    -- FACIAL_L_lipCornerThicknessUpper = 0x7BC,
    -- FACIAL_L_lipCornerThicknessLower = 0xDD42,
    -- FACIAL_R_lipUpperSDK = 0x7583,
    -- FACIAL_R_lipUpperAnalog = 0x51CF,
    -- FACIAL_R_lipUpperThicknessH = 0x382E,
    -- FACIAL_R_lipUpperThicknessV = 0x385C,
    -- FACIAL_R_lipCornerSDK = 0xB3C,
    -- FACIAL_R_lipCornerAnalog = 0xEE0E,
    -- FACIAL_R_lipCornerThicknessUpper = 0x54C3,
    -- FACIAL_R_lipCornerThicknessLower = 0x2BBA,
    -- MH_MulletRoot = 0x3E73,
    -- MH_MulletScaler = 0xA1C2,
    -- MH_Hair_Scale = 0xC664,
    -- MH_Hair_Crown = 0x1675,
    -- SM_Torch = 0x8D6,
    -- FX_Light = 0x8959,
    -- FX_Light_Scale = 0x5038,
    -- FX_Light_Switch = 0xE18E,
    -- BagRoot = 0xAD09,
    -- BagPivotROOT = 0xB836,
    -- BagPivot = 0x4D11,
    -- BagBody = 0xAB6D,
    -- BagBone_R = 0x937,
    -- BagBone_L = 0x991,
    -- SM_LifeSaver_Front = 0x9420,
    -- SM_R_Pouches_ROOT = 0x2962,
    -- SM_R_Pouches = 0x4141,
    -- SM_L_Pouches_ROOT = 0x2A02,
    -- SM_L_Pouches = 0x4B41,
    -- SM_Suit_Back_Flapper = 0xDA2D,
    -- SPR_CopRadio = 0x8245,
    -- SM_LifeSaver_Back = 0x2127,
    -- MH_BlushSlider = 0xA0CE,
    -- SKEL_Tail_01 = 0x347,
    -- SKEL_Tail_02 = 0x348,
    -- MH_L_Concertina_B = 0xC988,
    -- MH_L_Concertina_A = 0xC987,
    -- MH_R_Concertina_B = 0xC8E8,
    -- MH_R_Concertina_A = 0xC8E7,
    [34577] =  { name = "MH_L_ShoulderBladeRoot" },
    [20143] =  { name = "MH_L_ShoulderBlade" },
    [14858] =  { name = "MH_R_ShoulderBladeRoot" },
    [21679] =  { name = "MH_R_ShoulderBlade" },
    -- FB_R_Ear_000 = 0x6CDF,
    -- SPR_R_Ear = 0x63B6,
    -- FB_L_Ear_000 = 0x6439,
    -- SPR_L_Ear = 0x5B10,
    -- FB_TongueA_000 = 0x4206,
    -- FB_TongueB_000 = 0x4207,
    -- FB_TongueC_000 = 0x4208,
    [7531] =  { name = "SKEL_L_Toe1" },
    [45631] =  { name = "SKEL_R_Toe1" },
    -- SKEL_Tail_03 = 0x349,
    -- SKEL_Tail_04 = 0x34A,
    -- SKEL_Tail_05 = 0x34B,
    -- SPR_Gonads_ROOT = 0xBFDE,
    -- SPR_Gonads = 0x1C00,
    -- FB_L_Brow_Out_001 = 0xE3DB,
    -- FB_L_Lid_Upper_001 = 0xB2B6,
    -- FB_L_Eye_001 = 0x62AC,
    -- FB_L_CheekBone_001 = 0x542E,
    -- FB_L_Lip_Corner_001 = 0x74AC,
    -- FB_R_Lid_Upper_001 = 0xAA10,
    -- FB_R_Eye_001 = 0x6B52,
    -- FB_R_CheekBone_001 = 0x4B88,
    -- FB_R_Brow_Out_001 = 0x54C,
    -- FB_R_Lip_Corner_001 = 0x2BA6,
    -- FB_Brow_Centre_001 = 0x9149,
    -- FB_UpperLipRoot_001 = 0x4ED2,
    -- FB_UpperLip_001 = 0xF18F,
    -- FB_L_Lip_Top_001 = 0x4F37,
    -- FB_R_Lip_Top_001 = 0x4537,
    -- FB_Jaw_001 = 0xB4A0,
    -- FB_LowerLipRoot_001 = 0x4324,
    -- FB_LowerLip_001 = 0x508F,
    -- FB_L_Lip_Bot_001 = 0xB93B,
    -- FB_R_Lip_Bot_001 = 0xC33B,
    -- FB_Tongue_001 = 0xB987
}