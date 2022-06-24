Config = {}
Config.Locale = 'en'

Config.DoorList = {
	--
	-- Sandy Shores Kmar Hoofd Bureau
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.1, y = 3683.5, z = 34.2},
		textCoords = {x = 1855.1, y = 3683.5, z = 35.0},
		authorizedJobs = { 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Kantoor police
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1859.13, y = 3688.53, z = 34.26},
		textCoords = {x = 1859.13, y = 3688.53, z = 35.0},
		authorizedJobs = { 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Deur richting cellen
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1850.79, y = 3682.63, z = 34.26},
		textCoords = {x = 1850.79, y = 3682.63, z = 35.0},
		authorizedJobs = { 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Deur richting kantoortjes
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1856.96, y = 3689.66, z = 34.26},
		textCoords = {x = 1856.96, y = 3689.66, z = 35.0},
		authorizedJobs = { 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Deur naar Arsenaal vanuit lobby
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1848.34, y = 3690.51, z = 34.26},
		textCoords = {x = 1848.34, y = 3690.51, z = 35.0},
		authorizedJobs = { 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Deur naar Arsenaal vanuit cellen blok
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1846.30, y = 3690.38, z = 34.26},
		textCoords = {x = 1846.30, y = 3690.38, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},
	
	--Deur naar Arsenaal vanuit kleedkamer
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1849.03, y = 3692.84, z = 34.26},
		textCoords = {x = 1849.03, y = 3692.84, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Deur naar Kleedkamer vanuit kantoortjes
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 1852.32, y = 3694.73, z = 34.26},
		textCoords = {x = 1852.32, y = 3694.73, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Achterdeur naar buiten
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = {x = 1854.65, y = 3700.42, z = 34.26},
		textCoords = {x = 1854.65, y = 3700.42, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Cel 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1847.0, y = 3685.01, z = 34.26},
		textCoords = {x = 1847.0, y = 3685.01, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	--Cel 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 1845.27, y = 3688.01, z = 34.26},
		textCoords = {x = 1845.27, y = 3688.01, z = 35.0},
		authorizedJobs = { 'kmar', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},
	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.631, y = 6016.022, z = 32.00},
		authorizedJobs = { 'offpolice', 'police', 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = false,
		distance = 2.5
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.631, y = 6016.022, z = 32.00},
		authorizedJobs = { 'offpolice', 'police', 'kmar', 'offkmar' },
		authorizedRole = {},
		locked = false,
		distance = 2.5
	},


	-- Achteringang 1
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = {x = -450.97, y = 6006.075, z = 31.99},
		textCoords = {x = -451.64, y = 6006.78, z = 32.00},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Achteringang 2
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = {x = -447.2263, y = 6002.32, z = 31.83},
		textCoords = {x = -446.44, y = 6001.66, z = 31.70},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Dubbel Deur Links
	{
		objName = 'V_ILev_Bk_Door2',
		objCoords  = {x = -440.98, y = 6012.771, z = 31.716},
		textCoords = {x = -441.88,  y = 6011.92,  z = 31.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	{
		objName = 'V_ILev_Bk_Door2',
		objCoords  = {x = -442.8251, y = 6010.922, z = 31.716},
		textCoords = {x = -441.88,  y = 6011.92,  z = 31.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	-- Dubbele Deur Balie
	{
		objName = 'v_ilev_ss_door7',
		objCoords  = {x = -449.55, y = 6008.558, z = 31.8},
		textCoords = {x = -448.59,  y = 6007.74,  z = 31.8},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_ss_door8',
		objCoords  = {x = -447.7092, y = 6006.717, z = 31.8},
		textCoords = {x = -448.59,  y = 6007.74,  z = 31.8},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	-- Rechter single deur
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -449.7941, y = 6015.442, z = 31.816},
		textCoords = {x = -450.6141, y = 6016.23, z = 31.816},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	-- Cellen

	-- Cel Ingang
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -432.78, y = 5992.68, z = 31.72},
		textCoords = {x = -432.78, y = 5992.68, z = 32.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -428.68, y = 5997.17, z = 31.72},
		textCoords = {x = -428.68, y = 5997.17, z = 32.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	-- Cel 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -431.88, y = 6000.26, z = 31.72},
		textCoords = {x = -431.88, y = 6000.26, z = 32.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Verhoorkamer
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = {x = -454.53, y = 6011.258, z = 31.86},
		textCoords = {x = -453.5, y = 6011.38, z = 31.90},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Armory
	{
		objName = 'v_ilev_fingate',
		objCoords  = {x = -437.61, y = 5992.819, z = 31.93},
		textCoords = {x = -436.79, y = 5991.91, z = 31.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Armory 2
	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x = -441.47, y = 5990.24, z = 32.33},
		textCoords = {x = -440.45, y = 5989.29, z = 31.72},
		authorizedJobs = { 'kmar', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- Deur boven balkon 
	{
		objName = 'slb2k11_SECDOOR',
		objCoords  = {x = 463.49, y = -1011.17, z = 32.98},
		textCoords = {x = 463.09, y = -1011.21, z = 33.38},
		authorizedJobs = { 'offpolice', 'police' },
		authorizedRole = {},
		locked = true
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1844.998, y = 2604.810, z = 44.638},
		textCoords = {x = 1844.998, y = 2608.50, z = 48.00},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 2
	},
	-- Toren deuren

	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1820.772, y = 2620.77, z = 45.951},
		textCoords = {x = 1820.772, y = 2622.07, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1845.79, y = 2698.627, z = 45.951},
		textCoords = {x = 1845.79, y = 2699.627, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1772.13, y = 2760.027, z = 45.951},
		textCoords = {x = 1772.13, y = 2760.027, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1650.13, y = 2755.127, z = 45.951},
		textCoords = {x = 1650.13, y = 2755.127, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1571.83, y = 2678.527, z = 45.951},
		textCoords = {x = 1571.83, y = 2678.527, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1537.59, y = 2584.95, z = 45.951},
		textCoords = {x = 1537.59, y = 2584.95, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1543.56, y = 2470.327, z = 45.951},
		textCoords = {x = 1543.56, y = 2470.327, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1659.62, y = 2397.57, z = 45.951},
		textCoords = {x = 1659.62, y = 2397.57, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1760.64, y = 2413.117, z = 45.951},
		textCoords = {x = 1760.64, y = 2413.117, z = 45.951},
		authorizedJobs = { 'police', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1821.66, y = 2477.117, z = 45.951},
		textCoords = {x = 1821.66, y = 2477.117, z = 45.951},
		authorizedJobs = { 'police', 'police' },
		authorizedRole = {},
		locked = true,
		distance = 12,
		size = 1
	},





	--
	-- Addons
	--

	
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	-- {
	-- 	objName = 'prop_gate_airport_01',
	-- 	objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
	-- 	textCoords = {x = 420.133, y = -1021.00, z = 32.00},
	-- 	authorizedJobs = { 'police', 'kmar', 'brandweer', 'offpolice' },
	-- 	authorizedRole = {},
	-- 	locked = true,
	-- 	distance = 14,
	-- 	size = 2
	-- },
	

	-- Principial Bank
    -- {
    --     objName = 'hei_v_ilev_bk_gate2_pris',
    --     objCoords  = vector3(261.99899291992, 221.50576782227, 106.68346405029),
    --     textCoords = vector3(261.99899291992, 221.50576782227, 107.68346405029),
    --     authorizedJobs = { 'police' },
	-- authorizedRole = {},--     
	-- locked = true,
    --     distance = 12,
    --     size = 2
	-- },

-- 	-- Ziekenhuis Deuren
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 313.32, y = -596.34, z = 43.28},
		textCoords = {x = 313.18, y = -596.73, z = 43.48},
		authorizedJobs = { 'police', 'ambulance', 'offambulance' },
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 308.44, y = -597.52, z = 43.28},
		textCoords = {x = 308.05, y = -597.22, z = 43.48},
		authorizedJobs = { 'police', 'ambulance', 'offambulance' },
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 341.42, y = -582.21, z = 43.28},
		textCoords = {x = 341.9, y = -582.34, z = 43.48},
		authorizedJobs = { 'police', 'ambulance', 'offambulance' },
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 337.64, y = -592.84, z = 43.28},
		textCoords = {x = 338.11, y = -592.87, z = 43.48},
		authorizedJobs = { 'police', 'ambulance', 'offambulance' },
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = {x = 307.7, y = -569.87, z = 43.28},
		textCoords = {x = 308.2, y = -570.01, z = 43.48},
		authorizedJobs = { 'police', 'ambulance', 'offambulance' },
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},

	--- Gevangenis deuren
	-- 2e Deur richting hal
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1837.71, y = 2586.37, z = 45.87},
		textCoords = {x = 1837.71, y = 2586.37, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- 
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1837.71, y = 2594.01, z = 45.87},
		textCoords = {x = 1837.71, y = 2594.01, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- 
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1834.02, y = 2592.23, z = 45.87},
		textCoords = {x = 1834.02, y = 2592.23, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Linker Deur 3 deurs
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1828.89, y = 2584.54, z = 45.87},
		textCoords = {x = 1828.89, y = 2584.54, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Recht Deur 3 deurs
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1826.53, y = 2586.43, z = 45.87},
		textCoords = {x = 1826.53, y = 2586.43, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1828.48, y = 2587.44, z = 45.87},
		textCoords = {x = 1828.48, y = 2587.44, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Laatse deur uiteinde hal "Hekken"
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 1819.23, y = 2594.79, z = 45.87},
		textCoords = {x = 1819.23, y = 2594.79, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Hek 1 Zijkant Ingang
	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x = 1796.62, y = 2591.72, z = 46.32},
		textCoords = {x = 1796.62, y = 2591.72, z = 46.32},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Hek 2 Zijkant Ingang
	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x = 1796.2, y = 2596.58, z = 46.32},
		textCoords = {x = 1796.2, y = 2596.58, z = 46.32},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Ingang deur Cellenblok "Blauw"
	{
		objName = 'prison_prop_door1',
		objCoords  = {x = 1791.1, y = 2591.55, z = 46.27},
		textCoords = {x = 1791.1, y = 2593.81, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
    -- Ingang deur Cellenblok "Blauw"
	{
		objName = 'prison_prop_door1a',
		objCoords  = {x = 1790.96, y = 2595.9, z = 46.27},
		textCoords = {x = 1791.1, y = 2593.81, z = 46.27},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
    -- Blauwe uitgang deur achter balie
	{
		objName = 'prison_prop_door1',
		objCoords  = {x = 1785.19, y = 2600.21, z = 46.27},
		textCoords = {x = 1785.19, y = 2600.21, z = 46.17},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 1.7,
		size = 1.2
	},
	-- Voorraad hok deur balie
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1783.8, y = 2598.04, z = 46.27},
		textCoords = {x = 1783.8, y = 2598.04, z = 46.17},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 1.7,
		size = 1.2
	},
	-- Deur keuken
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1774.91, y = 2592.71, z = 46.17},
		textCoords = {x = 1774.91, y = 2592.71, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Deur Ziekenboeg buitenaknt
	{
		objName = 'prison_prop_door1',
		objCoords  = {x = 1791.62, y = 2552.49, z = 46.17},
		textCoords = {x = 1791.62, y = 2552.49, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
    -- Deur ziekenboeg vanaf binnen terein
	{
		objName = 'prison_prop_door1a',
		objCoords  = {x = 1776.1, y = 2552.5, z = 46.17},
		textCoords = {x = 1776.1, y = 2552.5, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Monitor hok deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1780.87, y = 2545.34, z = 46.17},
		textCoords = {x = 1780.87, y = 2545.34, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Maf hok
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1783.12, y = 2547.52, z = 46.17},
		textCoords = {x = 1783.12, y = 2547.52, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Maffe deur rond ziekenboeg
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1785.8, y = 2550.33, z = 46.17},
		textCoords = {x = 1785.8, y = 2550.33, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Kantoor deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1786.31, y = 2550.59, z = 49.68},
		textCoords = {x = 1786.31, y = 2550.59, z = 49.68},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1781.76, y = 2550.38, z = 49.68},
		textCoords = {x = 1781.72, y = 2552.04, z = 49.68},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe kantoor deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1781.81, y = 2553.78, z = 49.68},
		textCoords = {x = 1781.72, y = 2552.04, z = 49.68},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Deur richting buiten terein vanaf cellenblok
	{
		objName = 'prison_prop_door1a',
		objCoords  = {x = 1765.15, y = 2566.71, z = 45.57},
		textCoords = {x = 1765.15, y = 2566.71, z = 46.07},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Deur naar benzine tanks 2e verdieping cellen complex
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1771.69, y = 2570.49, z = 50.87},
		textCoords = {x = 1771.69, y = 2570.49, z = 50.87},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Watch room cellen complex
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1779.24, y = 2596.01, z = 50.87},
		textCoords = {x = 1779.24, y = 2596.01, z = 50.87},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muf hok
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1764.87, y = 2607.23, z = 50.87},
		textCoords = {x = 1764.87, y = 2607.23, z = 50.87},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1777.9, y = 2601.9, z = 50.87},
		textCoords = {x = 1779.69, y = 2601.86, z = 50.95},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe deur 2
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1781.24, y = 2601.87, z = 50.87},
		textCoords = {x = 1779.69, y = 2601.86, z = 50.95},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Nog een vage deur
	{
		objName = 'prison_prop_door1',
		objCoords  = {x = 1785.89, y = 2621.05, z = 46.17},
		textCoords = {x = 1785.89, y = 2621.05, z = 46.17},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe bal kamer deur
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1769.17, y = 2614.76, z = 46.17},
		textCoords = {x = 1769.17, y = 2614.76, z = 46.17},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Muffe bal kamer deur 2
	{
		objName = 'prison_prop_door2',
		objCoords  = {x = 1765.65, y = 2615.47, z = 46.17},
		textCoords = {x = 1765.65, y = 2615.47, z = 46.17},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
	-- Deur zijkant uitgang
	{
		objName = 'prison_prop_door1',
		objCoords  = {x = 1784.12, y = 2609.7, z = 46.47},
		textCoords = {x = 1785.85, y = 2609.69, z = 46.47},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
    -- Deur zijkant uitgang 2
	{
		objName = 'prison_prop_door1a',
		objCoords  = {x = 1787.62, y = 2609.88, z = 46.47},
		textCoords = {x = 1785.85, y = 2609.69, z = 46.47},
		authorizedJobs = {'police', 'kmar'},
		authorizedRole = {},
		locked = true,
		distance = 3,
		size = 1.2
	},
    -- Alle cel deuren gevangenis


		-- Vesspuci pd 
	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1094.62, y = -812.1, z = 19.37},
		textCoords = {x = -1093.59, y = -811.18, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1090.34, y = -808.77, z = 19.37},
		textCoords = {x = -1091.28, y = -809.48, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1092.53, y = -810.57, z = 19.37},
		textCoords = {x = -1093.59, y = -811.18, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1092.03, y = -810.24, z = 19.37},
		textCoords = {x = -1091.28, y = -809.48, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},


	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1062.3, y = -826.75, z = 19.43},
		textCoords = {x = -1061.41, y = -827.5, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},
	

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1060.95, y = -828.87, z = 19.43},
		textCoords = {x = -1061.41, y = -827.5, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},


	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1112.64, y = -825.98, z = 19.15},
		textCoords = {x = -1111.63, y = -825.22, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1110.61, y = -824.5, z = 19.32},
		textCoords = {x = -1111.63, y = -825.22, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 1.5
	},


	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1108.87, y = -842.04, z = 19.32},
		textCoords = {x = -1108.11, y = -843.09, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 2.0
	},


	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1107.33, y = -844.12, z = 19.32},
		textCoords = {x = -1108.11, y = -843.09, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 2.0
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1107.1, y = -844.46, z = 19.32},
		textCoords = {x = -1106.4, y = -845.42, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1105.61, y = -846.39, z = 19.32},
		textCoords = {x = -1106.4, y = -845.42, z = 19.57},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = false,
		distance = 1.5
	},
-- backdoor garage 
	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1111.16, y = -849.06, z = 13.48},
		textCoords = {x = -1112.07, y = -847.93, z = 13.78},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1112.96, y = -846.71, z = 13.48},
		textCoords = {x = -1112.07, y = -847.93, z = 13.78},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1108.9, y = -842.61, z = 13.68},
		textCoords = {x = -1107.98, y = -842.03, z = 13.68},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 1.5
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1100.93, y = -846.25, z = 13.69},
		textCoords = {x = -1101.95, y = -847.03, z = 13.69},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1102.91, y = -847.59, z = 13.69},
		textCoords = {x = -1101.95, y = -847.03, z = 13.69},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'vesp_door1',
		objCoords  = {x = -1085.72, y = -832.4, z = 11.04},
		textCoords = {x = -1086.5, y = -831.38, z = 11.34},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'vesp_door1',
		objCoords  = {x = -1087.21, y = -830.29, z = 11.04},
		textCoords = {x = -1086.5, y = -831.38, z = 11.34},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},


	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1085.72, y = -832.44, z = 14.88},
		textCoords = {x = -1086.48, y = -831.34, z = 14.88},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1087.16, y = -830.41, z = 14.88},
		textCoords = {x = -1086.48, y = -831.34, z = 14.88},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
--
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1076.42, y = -824.14, z = 15.03},
		textCoords = {x = -1075.4839, y = -823.397, z = 15.03},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1074.339, y = -822.57, z = 15.03},
		textCoords = {x = -1075.4839, y = -823.397, z = 15.03},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
	--
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1101.06, y = -827, z = 14.28},
		textCoords = {x = -1101.06, y = -827, z = 14.28},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



---- armory vespuci 
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1100.73, y = -826.74, z = 14.28},
		textCoords = {x = -1100.73, y = -826.74, z = 14.28},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},




--- vespuci fire exit
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1066.43, y = -827.46, z = 4.86},
		textCoords = {x = -1065.26, y = -828.03, z = 5.46},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1065.01, y = -829.3, z = 4.86},
		textCoords = {x = -1065.26, y = -828.03, z = 5.46},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1056.77, y = -839.25, z = 4.86},
		textCoords = {x = -1057.72, y = -839.99, z = 5.36},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1058.92, y = -840.68, z = 4.86},
		textCoords = {x = -1057.72, y = -839.99, z = 5.36},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},


	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1090.78, y = -846.74, z = 4.88},
		textCoords = {x = -1090.44, y = -847.88, z = 4.98},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1089.7, y = -848.54, z = 4.88},
		textCoords = {x = -1090.44, y = -847.88, z = 4.98},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1079.7, y = -855.34, z = 5.06},
		textCoords = {x = -1079.09, y = -855.47, z = 5.46},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},




-- vespici pd cells 


	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1073.47, y = -827.24, z = 5.48},
		textCoords = {x = -1072.82, y = -826.74, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},

{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1087.58, y = -829.83, z = 5.48},
		textCoords = {x = -1086.97, y = -829.16, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1086, y = -827.61, z = 5.48},
		textCoords = {x = -1086, y = -827.61, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1088.23, y = -824.71, z = 5.48},
		textCoords = {x = -1088.81, y = -823.87, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1090.63, y = -821.63, z = 5.48},
		textCoords = {x = -1091.26, y = -820.77, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1085.81, y = -827.87, z = 5.48},
		textCoords = {x = -1086.41, y = -826.94, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1093.56, y = -823.77, z = 5.48},
		textCoords = {x = -1094.22, y = -823.05, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1091.09, y = -826.94, z = 5.48},
		textCoords = {x = -1091.77, y = -826.16, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1088.83, y = -830.13, z = 5.48},
		textCoords = {x = -1089.48, y = -829.45, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = -1096.67, y = -819.94, z = 5.48},
		textCoords = {x = -1096.67, y = -819.94, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true
	},
	
	
--


	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1093.93, y = -816.39, z = 5.48},
		textCoords = {x = -1093.37, y = -817.27, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},


	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1092.46, y = -818.31, z = 5.48},
		textCoords = {x = -1093.37, y = -817.27, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1075.51, y = -822.89, z = 5.48},
		textCoords = {x = -1074.71, y = -822.27, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},




	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1073.6, y = -821.65, z = 5.48},
		textCoords = {x = -1074.71, y = -822.27, z = 5.58},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	----------------------------- back gate
	


	-- {
	-- 	objName = 'prop_facgate_01',
	-- 	objCoords  = {x = -1052.37, y = -872.72, z = 4.83},
	-- 	textCoords = {x = -1060.79, y = -877.53, z = 5.08},
	-- 	authorizedJobs = { 'police', 'offpolice', 'kmar' },
	-- 	authorizedRole = {},
	-- 	locked = true,
	-- 	distance = 20.0,
	-- 	size = 2
	-- },


	-- {
	-- 	objName = 'prop_facgate_01b',
	-- 	objCoords  = {x = -1063.84, y = -879.84, z = 5.08},
	-- 	textCoords = {x = -1058.15, y = -876.03, z = 5.08},
	-- 	authorizedJobs = { 'police', 'offpolice', 'kmar' },
	-- 	authorizedRole = {},
	-- 	locked = true,
	-- 	distance = 20.0,
	-- 	size = 2
	-- },
	


--- front door vespuci 



	{
		objName = 'vesp_door1',
		objCoords  = {x = -1091.14, y = -817.74, z = 19.04},
		textCoords = {x = -1092.1, y = -818.60, z = 19.37},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
	
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.14, y = -819.32, z = 19.04},
		textCoords = {x = -1092.1, y = -818.60, z = 19.37},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1097.71, y = -836.57, z = 19.0},
		textCoords = {x = -1098.45, y = -835.5, z = 19.3},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},



	{
		objName = 'vesp_door1',
		objCoords  = {x = -1099.33, y = -834.65, z = 19.0},
		textCoords = {x = -1098.45, y = -835.5, z = 19.3},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},




	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.98, y = -845.53, z = 19.0},
		textCoords = {x = -1094.85, y = -844.53, z = 19.0},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},

	
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1095.58, y = -843.38, z = 19.0},
		textCoords = {x = -1094.85, y = -844.53, z = 19.0},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},


	--- kantine boven
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1094.98, y = -842.9949, z = 23.18},
		textCoords = {x = -1094.19, y = -844.0949, z = 23.18},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},


	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.359, y = -845.04222, z = 23.18},
		textCoords = {x = -1094.19, y = -844.0949, z = 23.18},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
--3de verdieping Gym
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.383, y = -845.0, z = 26.8},
		textCoords = {x = -1094.23, y = -844.08, z = 26.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1094.948, y = -843.019, z = 26.8},
		textCoords = {x = -1094.23, y = -844.08, z = 26.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
	--4de verdieping
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.383, y = -845.0, z = 30.8},
		textCoords = {x = -1094.283, y = -844.02, z = 30.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1094.948, y = -843.019, z = 30.8},
		textCoords = {x = -1094.283, y = -844.02, z = 30.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
	--5de verdieping
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.359, y = -845.0, z = 34.5},
		textCoords = {x = -1094.283, y = -844.02, z = 34.5},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1094.928, y = -842.919, z = 34.5},
		textCoords = {x = -1094.283, y = -844.02, z = 34.5},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.0
	},
	---Verhoorkamer 1
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1082.152, y = -816.3433, z = 5.6},
		textCoords = {x = -1081.352, y = -817.0833, z = 5.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	---Verhookamer 2
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1078.52, y = -813.5617, z = 5.6},
		textCoords = {x = -1078.32, y = -814.4617, z = 5.8},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'prop_facgate_01b',
		objCoords  = {x = -1051.37, y = -871.18, z = 5.18},
		textCoords = {x = -1091.6042, y = -835.0757, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1090.7242, y = -836.03757, z = 5.6},
		textCoords = {x = -1091.6042, y = -835.0757, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	---Identicicatie 
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1096.712, y = -836.66757, z = 5.0},
		textCoords = {x = -1097.812, y = -837.56757, z = 5.0},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1098.779, y = -838.239, z = 5.0},
		textCoords = {x = -1097.812, y = -837.56757, z = 5.0},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	---Opslag ruimte tussen verhoor en cel
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1091.084, y = -813.01933, z = 5.6},
		textCoords = {x = -1090.484, y = -812.51933, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	-- dubbele deur richting cel bij verhoor
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1085.042, y = -812.5566, z = 5.6},
		textCoords = {x = -1085.8042, y = -811.4757, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1086.6342, y = -810.03757, z = 5.6},
		textCoords = {x = -1085.8042, y = -811.4757, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
--overige
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1071.45, y = -825.76, z = 11.8},
		textCoords = {x = -1072.55, y = -826.32, z = 11.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1073.55, y = -827.32, z = 11.1},
		textCoords = {x = -1072.55, y = -826.32, z = 11.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1077.55, y = -824.66, z = 11.1},
		textCoords = {x = -1078.65, y = -825.56, z = 11.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1079.62, y = -826.26, z = 11.1},
		textCoords = {x = -1078.65, y = -825.56, z = 11.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1095.45, y = -835.786, z = 10.1},
		textCoords = {x = -1094.45, y = -835.186, z = 10.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1093.427, y = -834.22, z = 10.1},
		textCoords = {x = -1094.45, y = -835.186, z = 10.4},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1068.07, y = -824.42, z = 27.19},
		textCoords = {x = -1069.463, y = -824.22, z = 27.19},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_door1',
		objCoords  = {x = -1070.63, y = -824.42, z = 27.19},
		textCoords = {x = -1069.463, y = -824.22, z = 27.19},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1095.49, y = -835.79, z = 14.43},
		textCoords = {x = -1094.529, y = -835.039, z = 14.43},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = -1093.429, y = -834.219, z = 14.43},
		textCoords = {x = -1094.529, y = -835.039, z = 14.43},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},	
	---Trapdeuren---
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1070.7827, y = -834.052, z = 5.6},
		textCoords = {x = -1071.5127, y = -833.12, z = 5.6},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1077.8127, y = -830.5732, z = 11.1854},
		textCoords = {x = -1076.9227, y = -830.02, z = 11.1854},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1077.8127, y = -830.5732, z = 15.1854},
		textCoords = {x = -1076.9227, y = -830.02, z = 15.1854},
		authorizedJobs = { 'police', 'offpolice', 'kmar' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1077.8127, y = -830.5732, z = 19.1854},
		textCoords = {x = -1076.9227, y = -830.02, z = 19.1854},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1077.8127, y = -830.5732, z = 23.1854},
		textCoords = {x = -1076.9227, y = -830.02, z = 23.1854},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1077.8127, y = -830.5732, z = 27.1854},
		textCoords = {x = -1076.9227, y = -830.02, z = 27.1854},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1089.599, y = -841.5602, z = 37.91},
		textCoords = {x = -1090.119, y = -840.7602, z = 37.91},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 34.51},
		textCoords = {x = -1091.419, y = -841.1602, z = 34.51},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 30.361},
		textCoords = {x = -1091.419, y = -841.1602, z = 30.361},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 26.501},
		textCoords = {x = -1091.419, y = -841.1602, z = 26.501},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 22.361},
		textCoords = {x = -1091.419, y = -841.1602, z = 22.361},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 18.361},
		textCoords = {x = -1091.419, y = -841.1602, z = 18.361},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 14.361},
		textCoords = {x = -1091.419, y = -841.1602, z = 14.361},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1090.799, y = -841.5602, z = 10.281},
		textCoords = {x = -1091.419, y = -841.1602, z = 10.281},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'xm_Prop_IAA_BASE_Door_01',
		objCoords  = {x = -1092.239, y = -843.1302, z = 5.01},
		textCoords = {x = -1092.949, y = -842.302, z = 5.01},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	--Deur boven naar buiten
	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1114.469, y = -830.197, z = 27.36},
		textCoords = {x = -1113.394, y = -829.427, z = 27.36},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},
	{
		objName = 'vesp_glav_door',
		objCoords  = {x = -1112.294, y = -828.527, z = 27.36},
		textCoords = {x = -1113.394, y = -829.427, z = 27.36},
		authorizedJobs = { 'police', 'offpolice' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
	},

    -- Deuren taxi office
	 {
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = {x = 900.81, y = -162.96, z = 83.49},
		textCoords = {x = 900.11, y = -162.90, z = 83.40},
		authorizedJobs = { 'taxi', 'offtaxi' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
		  },
									
		  {
		objName = 'apa_p_mp_yacht_door_02',
		objCoords  = {x = 899.51, y = -162.43, z = 83.40},
		textCoords = {x = 900.11, y = -162.90, z = 83.40},
		authorizedJobs = { 'taxi', 'offtaxi' },
		authorizedRole = {},
		locked = true,
		distance = 2.5
		 },

		 --==--==--BRATVA HEK
		 {
			objName = 'prop_facgate_07b',
			objCoords  = {x = -3137.31, y = 798.69, z = 17.32},
			textCoords = {x = -3135.34, y = 795.78, z = 17.33},
			authorizedJobs = { 'bratva' },
			authorizedRole = {},
			locked = true,
			distance = 6
			  },

	}