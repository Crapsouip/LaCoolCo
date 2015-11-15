/*  BIOBOT APPLICATION VERSION_1.0
  Application Processing pour PC
  @author Daman Maximilien  02/09/2014
*/
//Imports de donnees:
  import	processing.serial.*;
  import	processing.video.*;
  
  String CONNECT_COM = "COM10";
  
//Definitions generales:
	//Petit Cool:
	Serial	PetitCool;
	boolean	ReadAbility;
	//Configuration:
	String	PETITCOOL_CONFIG;
	String[]	COOL_CONFIG;
	int		DataNumber;
	long  	UpdateData;
	//Donnees Recues Petit Cool:
	String	CoolRawData;
	float[]	CoolData;
	int[]	LAST_UPDATED = new int[3];
	long	DataTimer;
	//Donnees Presentees Application:
	int		SORTED_DATA;
	float[]	CoolDataSorted;
	//Donnees recues navigation
	String	OrderToSend;
	boolean	IsOrdered;
	boolean Swap;
	//Architecture:
	XML		AppXML;
	XML		BotanicDB;
	//Parametres de Navigation:
	int		NavCount;
	int		ActionCount;
	String	NavMode;
	String	CurrentBG;
	int		CurrentPage;
	int		NextPage;
	int TOTAL_DIVISION = 87;
	float DynRate = 0.5;
	boolean[]	ModifyPage = new boolean[TOTAL_DIVISION];
	boolean[]	MouseOnZone = new boolean[TOTAL_DIVISION];
	boolean 	OnRelease = false;
	int[]		NextPages = new int[TOTAL_DIVISION];
	String[]	PotOrders = new String[TOTAL_DIVISION];
	boolean	ClickedZone;
	int[]		InteractiveZones = {	//	InteractiveZones.length = TOTAL_DIVISION	//
										60, 60,		//	0 - MENU HAMBURGER / BACK
										360, 60,	//	1 - MENU LOGO BAR 480*120px
										660, 60,	//	2 - MENU GOD MODE
										
										60, 180,	//	3 - ICON SEASON
										180, 180,	//	4
										300, 180,	//	5
										420, 180,	//	6
										540, 180,	//	7
										660, 180,	//	8
										
										60, 300,	//	9 - ICON LIGHT
										180, 300,	//	10
										300, 300,	//	11
										420, 300,	//	12
										540, 300,	//	13
										660, 300,	//	14	
										
										60, 420,	//	15 - ICON TEMPERATURE
										180, 420,	//	16
										300, 420,	//	17
										420, 420,	//	18
										540, 420,	//	19
										660, 420,	//	20
										
										60, 540,	//	21 - ICON HUMIDITY
										180, 540,	//	22
										300, 540,	//	23
										420, 540,	//	24
										540, 540,	//	25
										660, 540,	//	26
										
										60, 660,	//	27 - ICON PUMP
										180, 660,	//	28
										300, 660,	//	29
										420, 660,	//	30
										540, 660,	//	31
										660, 660,	//	32
										
										60, 780,	//	33 - ICON WATER LVL
										180, 780,	//	34
										300, 780,	//	35
										420, 780,	//	36
										540, 780,	//	37
										660, 780,	//	38
										
										60, 900,	//	39 - ICON SETTINGS
										180, 900,	//	40
										300, 900,	//	41
										420, 900,	//	42
										540, 900,	//	43
										660, 900,	//	44
										
										360, 987,	//	45 - TIME BAR 720*54px
										
										120, 1074,	//	46 - ON/OFF LIGHTS 240*120px
										360, 1074,	//	47 - ON/OFF PUMPS 240*120px
										600, 1074,	//	48 - ON/OFF FANS 240*120px
										
										360, 180,	//	49 - SPECIAL SEASON			1
										360, 300,	//	50 - SPECIAL LIGHT			1
										600, 300,	//	51 - SPECIAL LIGHT			2
										360, 420,	// 	52 - SPECIAL TEMPERATURE	1
										600, 420,	// 	53 - SPECIAL TEMPERATURE	2
										360, 540,	//	54 - SPECIAL HUMIDITY		1
										600, 540,	//	55 - SPECIAL HUMIDITY		2
										360, 660,	//	56 - SPECIAL PUMP 			1
										480, 780,	//	57 - SPECIAL WATLEV			1
										
										180, 180,	//	58 - SPECIAL SEASON			0
										180, 300,	//	59 - SPECIAL LIGHT			0
										180, 420,	// 	60 - SPECIAL TEMPERATURE	0
										180, 540,	//	61 - SPECIAL HUMIDITY		0
										180, 660,	//	62 - SPECIAL PUMP 			0
										180, 780,	//	63 - SPECIAL WATLEV			0
										180, 900,	//	64 - SPECIAL SETTINGS		0
										360, 900,	//	65 - SPECIAL SETTINGS		1
										
										300, 300,	//	66 - CENTERED LUMINOSITY LEFT
										360, 300,	//	67 - CENTERED LUMINOSITY CENTER
										420, 300,	//	68 - CENTERED LUMINOSITY RIGHT
										300, 420,	//	69 - CENTERED TEMPERATURE LEFT
										360, 420,	//	70 - CENTERED TEMPERATURE CENTER
										420, 420,	//	71 - CENTERED TEMPERATURE RIGHT
										300, 540,	//	72 - CENTERED HUMIDITY LEFT
										360, 540,	//	73 - CENTERED HUMIDITY CENTER
										420, 540,	//	74 - CENTERED HUMIDITY RIGHT
										300, 660,	//	75 - CENTERED PUMP LEFT
										360, 660,	//	76 - CENTERED PUMP CENTER
										420, 660,	//	77 - CENTERED PUMP RIGHT
										
										360, 540,	//	78 - CENTERED ALERT CENTER
										420, 420,	//	79 - GRAPH SMALL
										240, 660,	//	80 - SLIDER LED 1
										240, 780,	//	81 - SLIDER LED 2
										240, 900,	//	82 - SLIDER LED 3
										480, 660,	//	83 - SLIDER LED 4
										480, 780,	//	84 - SLIDER LED 5
										480, 900,	//	85 - SLIDER LED 6
										360, 420	//	86 - GRAPH SPECTRUM
									};
	int[]	ZonesSizes = new int[TOTAL_DIVISION];	
	//Parametres de l'application:
	long	WindowWidth;
	long	WindowHeight;
	int		AppFrameRate;
	PImage	BackG;
	PFont[]		CoolFont = new PFont[5];
	PImage[]	CoolIco = new PImage[TOTAL_DIVISION];
	boolean[]	CoolIcoOn = new boolean[TOTAL_DIVISION];
	int[]		TintIco = new int[TOTAL_DIVISION];
	//Recherches:
	String	Search;
	String	SearchBuffer;
	int		SearchBlink;
	//BlueTooth:
	int[]	BTParams;
	String	BTName;
	int[]	BTCode;
	//Capteurs:
	int		SENSOR_TYPE = 10;
	int		CONSIGNES_NB = 12;
	int		MODE_TYPE = 9;
	int[]	FIRST_READ = new int[SENSOR_TYPE];
	int[]	SENSOR = new int[SENSOR_TYPE];
	int[][]	SENSOR_MODE = new int[MODE_TYPE][14];
	int[]	COOL_CONSIGNES = new int[CONSIGNES_NB];
	int[][]	PINS = new int[SENSOR_TYPE][];
	long[][]	TIMERS = new long[SENSOR_TYPE-4][21];
	long[][]	LED_TIMERS = new long[18][3];
	String[]	SENSORLIST = 	{
									"BT",
									"RTC",
									"Lum",
									"DHT",
									"Pump",
									"Moist",
									"Led",
									"Display",
									"WatLev"
								};
	//Buffer Gestion Capteurs:
	int[]	SENSNav_Buffer = new int[6];
	boolean[]	FREE_PINS = new boolean[71];
	int[]		FREE_DIGITAL = new int[55];	//Taille a revoir
	int[]		FREE_ANALOG = new int[17];
	int[]		FREE_UART = new int[9];
	int[]		FREE_PWM = new int[12];
	//Graphiques:
	long[] GraphTimer = new long[3];
	long UpdateGraph;
	float[][]	LedParamSpectrum = {		//Fitting Donnees Constructeurs - Utiliser Fitting courbes puissances normalises
									{0.0383, 457.0406, 0.5605, 0.29, 459.3836, 6.1749, 0.7465, 459.6845, 15.309},		//LED 1 - 460 nm (L53PBCZ)
									{0.0539, 465.1402, 2.0598, 0.5029, 464.7337, 20.9439, 0.5122, 460.4128, 9.3309}, 	//LED 2 - 465 nm (HLMPCB25)
									{0.2565, 458.0086, 5.2315, 0.1253, 468.4227, 16.0119, 0.7134, 458.2305, 13.9937},	//Led 3 - 470 nm (L53MBC)
									{-0.0412, 516.8216, 0.3677, 0.5019, 523.5855, 28.5044, 0.5320, 515.9473, 13.904},	//LED 4 - 520 nm (HLMPAM65140DD)
									{0.2864, 632.8731, 4.5545, 0.1951, 624.4572, 19.9462, 0.5667, 631.6380, 10.5720},	//LED 5 - 630 nm (HLMPEG3BSV0DD)
									{0.1471, 661.2926, 3.1064, 0.6737, 660.8796, 10.7155, 0.1883, 659.9375, 24.6592}	//LED 6 - 660 nm (L53SRCE)
	};
	/*  //Autres:
    long  PictNumber;
    long  UpdateGraph;
    int    TimerPhoto;
	//Photo:
	long[]   PhotoTake   = new long[2];
	int    DispCam;
	//Horloge:
	float[] ClockPos  = new float[3];
	float[] Radii    = new float[3];  
	//Graphiques:
		//float[] xHumInt, yHumInt; 
		//float[] xHumExt, yHumExt;
	long[]   GraphPos  = new long[2];
	long[]  PointPos  = new long[2];
	long  GraphTimer; */
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
	
///////////////////////////////////////////////////////////////////////////////
////////////////////////////////SKETCH PROCESSING//////////////////////////////
///////////////////////////////////////////////////////////////////////////////
void setup() 
{
//Initialisation des donnees Applications:
	size(400, 200);
	if(frame != null) {	frame.setResizable(true);	}
	InitVariables();
	WindowSetup();
	PetitCoolConnection();
	WindowSetup();
}

void draw()
{
	PetitCoolRead();
	BackGroundDisplay();
	loadPageFromXML(CurrentPage);
    /*
		DisplayGraphSpace(CurrentPage);
		DisplayGraph(CurrentPage,0);
	*/
}

void mouseClicked()
{
	if(Swap)				FX_Swap();
	else if(ClickedZone)	FX_PChange();
	else if(IsOrdered)		FX_Order();
	else 					return;
}

void mouseDragged()
{
//Sliders:
	if(OrderToSend == null) return;
	if(OrderToSend.contains("SL:"))
	{
		int MousePosToPow = 0;
		int StatSize = int(WindowWidth/6.0);
		int DynSize = int(StatSize);		
		if(OrderToSend.contains("SL:7:"))		//Slider Led
		{
		//Recuperation des infos slider:
			String[] Order = OrderToSend.split(":");
			int Index = int(Order[2]);
			int Pos_Id = int(Order[3]);
			int SliderSens = (Order[4].equals("LR"))?1:((Order[4].equals("RL"))?-1:0);
			int SliderWidth = int(Order[5]);
		//Mise a jour puissance:
			MousePosToPow = int(map(SliderSens*mouseX - SliderSens*(InteractiveZones[2*Pos_Id] - SliderSens*SliderWidth/2), 0, SliderWidth, 0, 255));
			MousePosToPow = (MousePosToPow > 255)?255:((MousePosToPow < 0)?0:MousePosToPow);
				print("Slider: "); print(Index); print(" - Pow: "); print(MousePosToPow); println("/255");
		//Passage en mode Personalise:
			SENSOR_MODE[0][0] = 4;
			SENSOR_MODE[7][2*Index + 1] = MousePosToPow;
			OnRelease = true;
		}
	}
	else return;
}

void mouseReleased()
{
	if(OnRelease)
	{		
	//Sliders:
		if(OrderToSend.contains("SL:"))
		{		
			if(OrderToSend.contains("SL:7:"))		//Slider Led
			{
				String[] Test = OrderToSend.split(":");
				int Index = int(Test[2]);
			//Ecriture Ordre:
				OrderToSend = "L:SP:";
				OrderToSend += Index + ":" + SENSOR_MODE[7][2*Index+1];
			}
		}
		FX_Order();
		OnRelease = false;
	}
	else return;
}

void keyPressed()
{  //REVOIR BACKSPACE ACTION//
	//Limitation aux pages de recherches:
	if(!((NavMode.equals("Botanic"))&&(CurrentPage==0))) return;
	//Validation par touche ENTREE:
	if(key == '\n' )
	{
		SearchBuffer = Search;
		if((!SearchBuffer.equals(""))&&(!Search.equals("")))
		{
			Search = "";
			println("Requete vers : "+SearchBuffer);
			CurrentPage = 1;
		}
	}
	//Reconnaissance de chaine:
	else
	{
	//Effet des touches speciales:  
		if(key==CODED)
		{
			Search = (keyCode==BACKSPACE)?Search.substring(0, Search.length()-2):Search;
		}
	//Effet des autres touches:
		else Search += (key!=CODED)?key:null;
	}
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////INTERACTION SOURIS//////////////////////////////
///////////////////////////////////////////////////////////////////////////////
	void FX_Swap()
{	//	Ajouter Gestion Capteurs	//
	if(OrderToSend.equals("SEASON:MODE"))
	{
		print("Changement Mode Saison -> ");
		SENSOR_MODE[0][0]++;
		SENSOR_MODE[0][0] %= 5;
		println(SENSOR_MODE[0][0]);
		OrderToSend = "L:S:" + SENSOR_MODE[0][0];
		FX_Order();
	}
	if(OrderToSend.equals("P:M"))
	{
		print("Changement Mode Pompe -> ");
		SENSOR_MODE[1][0]++;
		SENSOR_MODE[1][0] %= 5;
		println(SENSOR_MODE[1][0]);
		OrderToSend = "P:M:" + SENSOR_MODE[1][0];
		FX_Order();
	}
	if(OrderToSend.contains("C:TEMP"))
	{
		println("Changement Consigne Temperature -> ");
		if(OrderToSend.equals("C:TEMP:+"))	COOL_CONSIGNES[6]++;
		else if(OrderToSend.equals("C:TEMP:-"))	COOL_CONSIGNES[6]--;
		else if(OrderToSend.equals("C:TEMP:S"))
		{
			NextPage = 2;
			OrderToSend = "C:6:" + COOL_CONSIGNES[6];
			FX_Order();
		}
	}
	if(OrderToSend.contains("C:HUM"))
	{
		println("Changement Consigne Humidite -> ");
		if(OrderToSend.equals("C:HUM:+"))	COOL_CONSIGNES[9]++;
		else if(OrderToSend.equals("C:HUM:-"))	COOL_CONSIGNES[9]--;
		else if(OrderToSend.equals("C:HUM:S"))
		{
			NextPage = 2;
			OrderToSend = "C:9:" + COOL_CONSIGNES[9];
			FX_Order();
		}
	}
	/* Sensors Infos */
	if(OrderToSend.contains("M:S"))
	{
		if(OrderToSend.equals("M:S:+"))
		{
			println("Changement Navigation Capteur -> ");
			if(SENSOR[SENSNav_Buffer[0]] == 0)
			{
				SENSNav_Buffer[1]++;
				SENSNav_Buffer[1] %= (SENSOR[SENSNav_Buffer[0]]+1);
			}
			else
			{
				SENSNav_Buffer[1]++;
				SENSNav_Buffer[1] %= SENSOR[SENSNav_Buffer[0]];
			}
		}
		else if(OrderToSend.equals("M:S:-"))
		{
			println("Changement Navigation Capteur -> ");
			if(SENSOR[SENSNav_Buffer[0]] == 0)
			{
				SENSNav_Buffer[1]--;
				SENSNav_Buffer[1] %= (SENSOR[SENSNav_Buffer[0]]+1);
			}
			else
			{
				SENSNav_Buffer[1]--;
				if(SENSNav_Buffer[1] < 0) SENSNav_Buffer[1] = -SENSNav_Buffer[1];
				SENSNav_Buffer[1] %= SENSOR[SENSNav_Buffer[0]];
			}
		}
		else if(OrderToSend.equals("M:S:Rem"))
		{
			println("Retrait Capteur -> ");
			NextPage = 2;
			if(NavMode.equals("NoMachine"))
			{
				CurrentPage = NextPage;
				return;
			}
			OrderToSend = "R:" + SENSNav_Buffer[0];
			OrderToSend += ":1:" + PINS[SENSNav_Buffer[0]][SENSNav_Buffer[1]];
			FX_Order();
			RequestCoolConfig();
			TreatCoolConfig();
			SENSNav_Buffer[1] = 0;
		}
		else if(OrderToSend.equals("M:S:Add"))
		{
			println("Ajout Capteur -> ");
			NextPage = 2;
			if(NavMode.equals("NoMachine"))
			{
				CurrentPage = NextPage;
				return;
			}
			OrderToSend = "A:" + SENSNav_Buffer[0] + ":1:";
			//UART
			if((SENSNav_Buffer[0] == 0)||(SENSNav_Buffer[0] == 10))
			{
				OrderToSend += FREE_UART[SENSNav_Buffer[5]] + ":" + FREE_UART[SENSNav_Buffer[5] + 1];
				SENSNav_Buffer[5] = 0;
			}
			//DIGITAL
			else if((SENSNav_Buffer[0] == 3)||(SENSNav_Buffer[0] == 9))
			{
				OrderToSend += FREE_DIGITAL[SENSNav_Buffer[2]];
				SENSNav_Buffer[2] = 0;
			}
			//PWM
			else if((SENSNav_Buffer[0] == 4)||(SENSNav_Buffer[0] == 5)||(SENSNav_Buffer[0] == 7))
			{
				OrderToSend += FREE_PWM[SENSNav_Buffer[3]];
				SENSNav_Buffer[3] = 0;
			}
			//ANALOGIQUE
			else if((SENSNav_Buffer[0] == 2)||(SENSNav_Buffer[0] == 6))
			{
				OrderToSend += FREE_ANALOG[SENSNav_Buffer[4]];
				SENSNav_Buffer[4] = 0;
			}
			//Envoi:
			FX_Order();
			RequestCoolConfig();
			TreatCoolConfig();
		}
		else if(OrderToSend.equals("M:S:P:-"))
		{
			println("Changement Navigation Pin Libres -> ");
			//DIGITAL
			if(FREE_DIGITAL[0] == 0)
			{
				SENSNav_Buffer[2]--;
				SENSNav_Buffer[2] %= (FREE_DIGITAL[0]+1);
			}
			else
			{
				SENSNav_Buffer[2]--;
				if(SENSNav_Buffer[2] < 0) SENSNav_Buffer[2] = FREE_DIGITAL[0] + SENSNav_Buffer[2];
				SENSNav_Buffer[2] %= FREE_DIGITAL[0];
			}
			//PWM:
			if(FREE_PWM[0] == 0)
			{
				SENSNav_Buffer[3]--;
				SENSNav_Buffer[3] %= (FREE_PWM[0]+1);
			}
			else
			{
				SENSNav_Buffer[3]--;
				if(SENSNav_Buffer[3] < 0) SENSNav_Buffer[3] = -SENSNav_Buffer[3];
				SENSNav_Buffer[3] %= FREE_PWM[0];
			}
			//ANALOGIQUE:
			if(FREE_ANALOG[0] == 0)
			{
				SENSNav_Buffer[4]--;
				SENSNav_Buffer[4] %= (FREE_ANALOG[0]+1);
			}
			else
			{
				SENSNav_Buffer[4]--;
				if(SENSNav_Buffer[4] < 0) SENSNav_Buffer[4] = -SENSNav_Buffer[4];
				SENSNav_Buffer[4] %= FREE_ANALOG[0];
			}
			//UART:
			if(FREE_UART[0] == 0)
			{
				SENSNav_Buffer[5]--;
				SENSNav_Buffer[5] %= (FREE_UART[0]+1);
			}
			else
			{
				SENSNav_Buffer[5]--;
				if(SENSNav_Buffer[5] < 0) SENSNav_Buffer[5] = -SENSNav_Buffer[5];
				SENSNav_Buffer[5] %= FREE_UART[0];
			}
		}
		else if(OrderToSend.equals("M:S:P:+"))
		{
			//DIGITAL:
			println("Changement Navigation Capteur -> ");
			if(FREE_DIGITAL[0] == 0)
			{
				SENSNav_Buffer[2]++;
				SENSNav_Buffer[2] %= (FREE_DIGITAL[0]+1);
			}
			else
			{
				SENSNav_Buffer[2]++;
				SENSNav_Buffer[2] %= FREE_DIGITAL[0];
			}
			//PWM:
			if(FREE_PWM[0] == 0)
			{
				SENSNav_Buffer[3]++;
				SENSNav_Buffer[3] %= (FREE_PWM[0]+1);
			}
			else
			{
				SENSNav_Buffer[3]++;
				SENSNav_Buffer[3] %= FREE_PWM[0];
			}
			//ANALOG:
			if(FREE_ANALOG[0] == 0)
			{
				SENSNav_Buffer[4]++;
				SENSNav_Buffer[4] %= (FREE_ANALOG[0]+1);
			}
			else
			{
				SENSNav_Buffer[4]++;
				SENSNav_Buffer[4] %= FREE_ANALOG[0];
			}
			//UART:
			if(FREE_UART[0] == 0)
			{
				SENSNav_Buffer[5] += 2;
				SENSNav_Buffer[5] %= (FREE_UART[0]+1);
			}
			else
			{
				SENSNav_Buffer[5] += 2;
				SENSNav_Buffer[5] %= FREE_UART[0];
			}
		}
	}

//Sliders:
	if(OrderToSend.contains("SL:"))
	{
		int MousePosToPow = 0;
		int StatSize = int(WindowWidth/6.0);
		int DynSize = int(StatSize);		
		if(OrderToSend.contains("SL:7:"))		//Slider Led
		{
		//Recuperation des infos slider:
			String[] Order = OrderToSend.split(":");
			int Index = int(Order[2]);
			int Pos_Id = int(Order[3]);
			int SliderSens = (Order[4].equals("LR"))?1:((Order[4].equals("RL"))?-1:0);
			int SliderWidth = int(Order[5]);
		//Mise a jour puissance:
			MousePosToPow = int(map(SliderSens*mouseX - SliderSens*(InteractiveZones[2*Pos_Id] - SliderSens*SliderWidth/2), 0, SliderWidth, 0, 255));
			MousePosToPow = (MousePosToPow > 255)?255:((MousePosToPow < 0)?0:MousePosToPow);
				print("Slider: "); print(Index); print(" - Pow: "); print(MousePosToPow); println("/255");
		//Passage en mode Personalise:
			SENSOR_MODE[0][0] = 4;
			SENSOR_MODE[7][2*Index + 1] = MousePosToPow;
		//Ecriture Ordre:
			OrderToSend = "L:SP:";
			OrderToSend += Index + ":" + MousePosToPow;
			FX_Order();
		}
		else if(OrderToSend.contains("SL:S:"))	//Sauvegarde Configuration Sliders
		{
			if(OrderToSend.equals("SL:S:7")) OrderToSend = "L:SPS";
			FX_Order();
		}
	}
	CurrentPage = NextPage;
	return;
}

void FX_PChange()
{
	CurrentPage = NextPage;
	printPageChange();
	return;
}

void FX_Order()
{
	if(!NavMode.equals("Connected")) return;
	PetitCool.clear();
	WriteCoolAction(OrderToSend);
	PetitCool.clear();
	return;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/////////////////////////FONCTIONS D'INITIALISATION--A0////////////////////////
///////////////////////////////////////////////////////////////////////////////
void InitVariables()
{	//OBTENTION RAPPORT DYNAMIQUE//	
	DynRate = 0.5;		//	<----
	for(int i = 0; i < 2*TOTAL_DIVISION; i++)	{	InteractiveZones[i] = int(InteractiveZones[i]*DynRate);	}
	print("Initialisation Application\n\tInitialisation des donnees\n");
	//Donnees Application:
	setupAppXML();
	//Donnees Entrantes:
	CoolRawData = null;
	for(int i = 0; i < SENSOR_TYPE; i++)	{	FIRST_READ[i] = 0;	}
	for(int i = 0; i < CONSIGNES_NB; i++)	{	COOL_CONSIGNES[i] = -1;	}
	for(int i = 0; i < MODE_TYPE; i++)		{	for(int j = 0; j < 14; j++)	{	SENSOR_MODE[i][j] = 0;}	}
	for(int i = 0; i < SENSOR_TYPE-4; i++)	{	for(int j = 0; j < 21; j++)	{	TIMERS[i][j] = 0;}	}
	for(int i = 0; i < 18; i++)			{	for(int j = 0; j < 3; j++)	{	LED_TIMERS[i][j] = 0;}	}
	DataTimer = 0;
	//Navigation:
	NavMode = "Connected";
	CurrentPage = 1;
	NextPage = 1;
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		ModifyPage[i] = false;
		NextPages[i] = 0;
		PotOrders[i] = "";
		ZonesSizes[i] = 30;
		CoolIcoOn[i] = false;
		TintIco[i] = 0;
	}
	ClickedZone = false;
	IsOrdered = false;
	Swap = false;
	for(int i = 0; i < 6; i++) {	SENSNav_Buffer[i] = 0;	}
	for(int i = 0; i < 71; i++)	{	FREE_PINS[i] = true;	}
	for(int i = 0; i < 55; i++)	{	FREE_DIGITAL[i] = 0;	}
	for(int i = 0; i < 17; i++)	{	FREE_ANALOG[i] = 0;	}
	for(int i = 0; i < 9; i++)	{	FREE_UART[i] = 0;	}
	for(int i = 0; i < 12; i++)	{	FREE_PWM[i] = 0;	}
	//Graphiques:
	for(int i = 0; i < 3; i++)	{	GraphTimer[i] = 0;	}
	//Recherches:
	Search = "";
	SearchBuffer = "";
	SearchBlink = 0;
	print("\tDonnees Initialisees\n");
}

void setupAppXML()
{
	println("\tLecture du XML");
	//Parcours du fichier XML:
	AppXML = loadXML("PetitCool_App.xml");
	XML	TagSelect = AppXML.getChild("Initialisation").getChild("Update");
	UpdateData = TagSelect.getInt("data");
	UpdateGraph = TagSelect.getInt("graph");
	TagSelect = AppXML.getChild("Initialisation").getChild("Window");
	WindowWidth = TagSelect.getInt("width");
	WindowHeight = TagSelect.getInt("height");
	AppFrameRate = TagSelect.getInt("fps");
	TagSelect = AppXML.getChild("Initialisation").getChild("Background");
	CurrentBG = TagSelect.getString("img");
	//Finalisation:
	BackG = loadImage(CurrentBG);
	println("    Fermeture du XML");
}

	void PetitCoolConnection()
{	//	Ajouter Fenetre temps de connection machine	//
//Choix du port de Connexion:
	String[] portList = Serial.list();
	print("  Connexion Serial:");
		print(portList);
//Attente de choix Utilisateur:
	/* String ChosenPort = null;
	boolean Checked = false;
	while(!Checked)
	{
		
	} */
	
	boolean Test = false;
	for(int i = 0; i < portList.length; i++)	{	Test = Test||(portList[i].equals(CONNECT_COM));	} 
	if((portList.length > 0)&&Test) InitConnection(portList);
	else
	{
		println("    Pas de Serial Connecte");
		ReadAbility = false;
		NavMode = "NoMachine";
	}
	
}

void WindowSetup()
{
	size((int)(WindowWidth), (int)(WindowHeight));
	print("\tInitialisation de la fenetre graphique\n");
	background(255);
	smooth();
	frameRate(AppFrameRate);
	CoolFont[0] = createFont("1Montserrat-Hairline.otf", 40);
	CoolFont[1] = createFont("2Montserrat-Light.otf", 40);
	CoolFont[2] = createFont("3Montserrat-Regular.otf", 40);
	CoolFont[3] = createFont("4Montserrat-Bold.otf", 40);
	CoolFont[4] = createFont("5Montserrat-Black.otf", 40);
	println("\tFenetre graphique initialisee\nInitialisation Application Terminee\nMode de Navigation : "+NavMode);
	DataTimer = millis();
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/////////////////////////FONCTIONS D'INITIALISATION--A1////////////////////////
///////////////////////////////////////////////////////////////////////////////
	void InitConnection(String[] portList)
{	//PROBLEMES BLUETOOTH//
	print("\t");
	println(portList);
	String portName = portList[0];
	PetitCool = new Serial(this,CONNECT_COM,9600);
	PetitCool.clear();
	ReadAbility = true;
	print("\tConnexion serial effectuee\n");
	WaitForInitDone();
	println("Connexion initialisee");
}

void WaitForInitDone()
{
	int i = 0;
	String Test = null;
	CoolRawData = PetitCool.readStringUntil(10);
	while(i < 3)
	{
		CoolRawData = PetitCool.readStringUntil(10);
		if(CoolRawData != null)
		{
			PetitCool.write("Hello\n");
			Test = CoolRawData;
			if((i != 1))  {  print("\t");  print(CoolRawData);  }
			if((i == 1)&&(match(Test, "]") != null))  {  print("\t");  print(CoolRawData);  i = 2;  }
			if(((trim(Test).equals("Done."))||(trim(Test).equals("Connexion BlueTooth engagee.")))&&(i == 0))
			{
				boolean Conf = false;
				while(!Conf)
				{
					RequestCoolConfig();
					Conf = !Conf;
				}
				PetitCool.clear();
				i = -1;
			}
			if((trim(Test).equals("Mise a l'heure par Application"))||(i == -1))
			{
				PetitCool.clear();
				boolean Setup = false;
				while(!Setup)  {  CoolTimeSetup();  Setup = !Setup; }
				PetitCool.clear();
				i = 1;
			}
			if(trim(Test).equals("Biobot Initialise"))
			{
				TreatCoolConfig();  i = 3;
			}
		}
	}
}

void CoolTimeSetup()
{
//Initialisation:
	boolean[] Test = new boolean[3];
	for(int i = 0; i<3; i++ ) { Test[i] = false;  }
	int[] DateTime = new int[6];
	String[] DateTimeToSend = new String[6];
	DateTime[0] = day();  DateTime[1] = month();  DateTime[2] = year();
	DateTime[3] = hour();  DateTime[4] = minute();  DateTime[5] = second();
	print("\t\tMise a l'heure:\n\t\t\tHeure Application:\t\n");
	println(DateTime[3] + ":" + DateTime[4] + ":" + DateTime[5]);
	for(int k = 0; k<6; k++)  
	{
		if(k != 2) DateTimeToSend[k] = "?" + String.valueOf(k) + ";" + String.valueOf(DateTime[k]) + "!" + "\n";
		else DateTimeToSend[k] = "?" + String.valueOf(k) + ";" + String.valueOf(DateTime[k]-2000) + "!" + "\n";  
	}
	//Communication:
	CommBegin(Test[0], "R:T\n", "A:T");
	CommBodySend(Test, 6, DateTimeToSend, "R:N", "N:T");  
	//Synchronisation:
	print("\t\tHeure et Date Synchronisees\t");
	print(DateTime[3]); print(":");print(DateTime[4]);print(":");println(DateTime[5]);
	PetitCool.clear();
}

void RequestCoolConfig()
{
//Initialisation:
	boolean[] Test = new boolean[3];
	for(int i = 0; i<3; i++ ) { Test[i] = false;  }
	String DataToFill = "";
	println("\t\t\tLecture de la Cool Config:");
//Communication:
	CommBegin(Test[0], "R:C\n", "A:C");
//Reception des donnees:
	DataToFill = CommBodyReceive(Test, "N:C\n", "C:N\n");
	PETITCOOL_CONFIG = DataToFill.substring(1, DataToFill.length()-1);	
	int SizeOfConfig = PETITCOOL_CONFIG.charAt(0)-'0' + 48;
	if(SizeOfConfig > 255) SizeOfConfig = ConvertUnicodeToAscii(SizeOfConfig);
	COOL_CONFIG = new String[SizeOfConfig + 1];
	for(int i = 0; i < SizeOfConfig; i++)
	{
		int AsciiTest = PETITCOOL_CONFIG.charAt(i)-'0' + 48;
		if(AsciiTest > 255) AsciiTest = ConvertUnicodeToAscii(AsciiTest);
		COOL_CONFIG[i] = str(AsciiTest);
	}
//Synchronisation:
	print("\t\t\tConfiguration Machine connue : ");
	for(int i = 0; i < SizeOfConfig; i++) {	print(COOL_CONFIG[i]); print(":");	}
	println();
	PetitCool.clear();
	LAST_UPDATED[0] = hour();
	LAST_UPDATED[1] = minute();
	LAST_UPDATED[2] = second();
}

	int ConvertUnicodeToAscii(int ToConvert)
{	//	Augmenter	->	Methode Generale	???	//
	int Converted;
	if(ToConvert == 381) Converted = 142;
	else if(ToConvert == 8225) Converted = 135;
	else if(ToConvert == 352) Converted = 138;
	else if(ToConvert == 8218) Converted = 132;
	else Converted = ToConvert;
	return Converted;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////FONCTIONS DE COMMUNICATION//////////////////////////
///////////////////////////////////////////////////////////////////////////////
void CommBegin(boolean Test, String ToSend, String Requested)
{
  String Data = "";
  print("\t\t\t\tTentative de Communication\n");
  while(!Test)
  {
    PetitCool.write(ToSend);
    Data = PetitCool.readStringUntil(10);
    Data = (Data==null)?"Retry\n":Data;
	//if(!Data.equals("Retry\n")) println(Data);
    Test = (match(Data,Requested) != null);
  }
  Test = false;
  print("\t\t\t\tCommunication Etablie\n");
}

void CommBodySend(boolean[] Test, int nb_do, String[] ToSend, String Next, String Requested)
{
	while(!Test[2])
	{
		for(int k = 0; k<nb_do; k++)
		{
			while((!Test[0])&&(!Test[1]))
			{
				CommSendData(k, Test, ToSend[k]);
				CommSendNext(k, Test, Next, Requested);
			}
			CommEndLoop(Test);
		}
		PetitCool.clear();
		println("\t\t\t\tFin de recuperation");
		EndComm(Test);
	}
	println("\t\t\t\tCommunication Terminee");
}

void CommBodySend(boolean[] Test, String ToSend, String Next, String Requested)
{
	while(!Test[2])
	{
		while((!Test[0])&&(!Test[1]))
		{
			CommSendData(0, Test, ToSend);
			CommSendNext(0, Test, Next, Requested);
		}
			Test[0] = false;
		PetitCool.clear();
		println("\t\t\t\tFin de recuperation");
		EndComm(Test);
	}
	println("\t\t\t\tCommunication Terminee");
}

void CommSendData(int i, boolean[] Test, String ToSend)
{
    String Data = "";
    String Next = ToSend;
    Next.concat(str(i) + "\n");
    while(!Test[1])
    {
      PetitCool.write(Next);
      Data = PetitCool.readStringUntil(10);
      Data = (Data==null)?"Retry\n":Data;
      Test[1] = (match(Data,"Received") != null);
    }
    print("\t\t|__ Received # __| ");
}

void CommSendNext(int i, boolean[] Test, String ToSend, String Requested)
{
	String Data = "";
	String[] Req = new String[2];
	Req[0] = ToSend.concat(str(i) + "\n");
	Req[1] = Requested.concat(str(i));
	while(!Test[0])
	{
		PetitCool.write(Req[0]);
		Data = PetitCool.readStringUntil(10);
		Data = (Data==null)?"Retry\n":Data;
		Test[0] = (match(Data,Req[1]) != null);
	}
	print(str(i));
	print(" <~> |>Next<|\n");
}

String CommBodyReceive(boolean[] Test, String Next, String Requested)
{
	String Received = "";
	while(!Test[2])
	{
		while((!Test[0])&&(!Test[1]))
		{
			Received = CommReceiveData(Test, "?!");
			CommReceiveNext(Test, Next, Requested);
		}
		CommEndLoop(Test);
		PetitCool.clear();
		println("\t\t\t\tFin de recuperation");
		EndComm(Test);
	}
	println("\t\t\t\tCommunication Terminee");
	return Received;
}

String CommReceiveData(boolean[] Test, String SpecialChar)
{
	String ToReceive = "";
	while(!Test[1])
	{
		PetitCool.write("Retry\n");
		ToReceive = PetitCool.readStringUntil(SpecialChar.charAt(1)-'0'+48);
		ToReceive = (ToReceive==null)?"Retry\n":ToReceive;
		Test[1] = (ToReceive.charAt(0)== SpecialChar.charAt(0));//&&(ToReceive.charAt(ToReceive.length()-1) == SpecialChar.charAt(1));
	}
	Test[1] = false;
	print("\t\t\t|__ Received # __|");
	return ToReceive;
}

void CommReceiveNext(boolean[] Test, String Next, String Requested)
{
	String Data = "";
	while(!Test[1])
	{
		PetitCool.write(Next);
		Data = PetitCool.readStringUntil(10);
		Data = (Data==null)?"Retry\n":Data;
		Test[1] = (match(Data,Next.substring(0,Next.length()-1)) != null);
	}
	print(" <~> |>Next<|");
	while(!Test[0])
	{
		PetitCool.write(Requested);
		Data = PetitCool.readStringUntil(10);
		Data = (Data==null)?"Retry\n":Data;
		Test[0] = (match(Data,"EOC") != null);
	}
	print(" <~> |>End<|\n");
}

void CommEndLoop(boolean[] Test)
{
	Test[0] = false;
	Test[1] = false;
	Test[2] = false;
}

	void EndComm(boolean[] Test)
{	//Retirer Ecriture serial restante	//
	String Data = "";
	println("\t\t\t\tTerminaison de la communication");
	while(!Test[0])
	{  
		PetitCool.write("EOC\n");
		Data = PetitCool.readStringUntil(10);
		Data = (Data==null)?"Retry\n":Data;
		Test[0] = (match(Data,"EOC") != null)?true:false;
			println(Data);
			delay(150);
	}
	Test[2] = Test[0];
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
////////////////FONCTIONS DE LECTURE ET D'ECRITURE VERS BIOBOT/////////////////
///////////////////////////////////////////////////////////////////////////////
void PetitCoolRead()
{
	if(ReadAbility&&(millis() - DataTimer > UpdateData))
	{
		String[] Data;
		print("Lecture des Cool Infos:\t");
		CoolRawData = "";
		while(CoolRawData.equals(""))
		{
			CoolRawData = PetitCool.readStringUntil(10);
			if(CoolRawData == null)	CoolRawData = "null";
		}
		Data = CoolRawData.split(":");
		print(Data.length);
		print("\t");
		if (Data.length == DataNumber)
		{
			for(int i = 0; i<DataNumber; i++)	{	CoolData[i] = float(Data[i]);	}
			print(CoolRawData);
		}
		else
		{  
			print("\tFAILED\t");
			println(CoolRawData);
		}
		DataTimer = millis();
		PetitCool.clear();
		sortCoolData();
	}
}

	void PetitCoolStabiliseOrder()
{	//	Non Necessaire	//
	if(ReadAbility)
	{
		int TimeInterval = 50;
		String[] Data;
		boolean EndTest = true;
		/* CoolRawData = PetitCool.readStringUntil(10);
		if(CoolRawData == null)	CoolRawData = "null"; */
		print("\tStabilisation 1 -> Remainder : ");
		delay(TimeInterval);
		while(EndTest)
		{
			CoolRawData = PetitCool.readStringUntil(10);
			if(CoolRawData == null)	CoolRawData = "null";
			Data = CoolRawData.split(":");
			if(Data.length != DataNumber)	PetitCool.write("EOC\n");
			else
			{
				EndTest = false;
				for(int i = 0; i < DataNumber; i++)	{	CoolData[i] = float(Data[i]);	}
			}
			delay(TimeInterval);
		}
		print(CoolRawData);
		println("\tStabilisé.");
		PetitCool.clear();
		sortCoolData();
		long Temp = UpdateData;
		UpdateData = 0;
		PetitCoolRead();
		UpdateData = Temp;
	}
}

	void sortCoolData()
{	//Ajouter Water Level//
//Date et heure:
	CoolDataSorted[0] = year();
	CoolDataSorted[1] = month();
	CoolDataSorted[2] = day();
	for(int i = 3; i < 6; i++)			{	CoolDataSorted[i] = LAST_UPDATED[i-3];	}
//Moyennes Capteurs:
	int[] TOT = {0, 0};
	int[] VAL = {0, 0, 0, 0};
	int FirstData = 0;
//Luminosite:
	FirstData = FIRST_READ[2];
	//Calcul des moyennes:
	for(int i = 0; i < SENSOR[2]; i++)
	{
		//Interieure:
		if(SENSOR_MODE[2][i] == 0)
		{
			VAL[0] += CoolData[FirstData + i];
			TOT[0]++;
		}
		//Exterieure:
		if(SENSOR_MODE[2][i] == 1)
		{
			VAL[1] += CoolData[FirstData + i];
			TOT[1]++;
		}
	}
	TOT[0] = (TOT[0] == 0)?1:TOT[0];
	TOT[1] = (TOT[1] == 0)?1:TOT[1];
	//Post-Traitement (Statuts):
	if(SENSOR[2] == 1)
	{
		CoolDataSorted[6] = (SENSOR_MODE[2][0] == 1)?map(VAL[0]/TOT[0], 800, 0, 100, 0):2;
		CoolDataSorted[7] = (SENSOR_MODE[2][0] == 1)?-2:map(VAL[1]/TOT[1], 800, 0, 100, 0);
	}
	else if(SENSOR[2] > 1)
	{
		CoolDataSorted[6] = map(VAL[0]/TOT[0], 800, 0, 100, 0);
		CoolDataSorted[7] = map(VAL[1]/TOT[1], 800, 0, 100, 0);
	}
	else if(SENSOR[2] == 0)
	{
		CoolDataSorted[6] = -2;
		CoolDataSorted[7] = -2;
	}
	//RaZ:
	for(int i = 0; i < 2; i++)	{	TOT[i] = 0;	VAL[2*i] = 0; VAL[2*i + 1] = 0;	}
//Temperature & Humidite:
	FirstData = FIRST_READ[3];
	//Calcul des moyennes:
	for(int i = 0; i < SENSOR[3]; i++)
	{
		//Interieure:
		if(SENSOR_MODE[3][i] == 0)
		{
			VAL[0] += CoolData[FirstData + 2*i];
			VAL[2] += CoolData[FirstData + 2*i+1];
			TOT[0]++;
		}
		//Exterieure:
		if(SENSOR_MODE[3][i] == 1)
		{
			VAL[1] += CoolData[FirstData + 2*i];
			VAL[3] += CoolData[FirstData + 2*i+1];
			TOT[1]++;
		}
	}
	TOT[0] = (TOT[0] == 0)?1:TOT[0];
	TOT[1] = (TOT[1] == 0)?1:TOT[1];
	//Post-Traitement:
	if(SENSOR[3] == 0)
	{
		CoolDataSorted[8] = -100;
		CoolDataSorted[9] = 1.8*CoolDataSorted[8] + 32;
		CoolDataSorted[10] = -2;
		CoolDataSorted[11] = -100;
		CoolDataSorted[12] = 1.8*CoolDataSorted[11] + 32;
		CoolDataSorted[13] = -2;
	}
	else if(SENSOR[3] == 1)
	{
		CoolDataSorted[8] = (SENSOR_MODE[3][0] == 0)?(VAL[0]/TOT[0]):-100;
		CoolDataSorted[9] = 1.8*CoolDataSorted[8] + 32;
		CoolDataSorted[10] = (SENSOR_MODE[3][0] == 0)?(VAL[2]/TOT[0]):-2;
		CoolDataSorted[11] = (SENSOR_MODE[3][0] == 1)?(VAL[0]/TOT[0]):-100;
		CoolDataSorted[12] = 1.8*CoolDataSorted[8] + 32;
		CoolDataSorted[13] = (SENSOR_MODE[3][0] == 1)?(VAL[2]/TOT[0]):-2;
	}
	else if(SENSOR[3] > 1)
	{
		CoolDataSorted[8] = (VAL[0]/TOT[0]);			//T Int °C
		CoolDataSorted[9] = 1.8*(VAL[0]/TOT[0])+32;		//T Int °F
		CoolDataSorted[10] = (VAL[2]/TOT[0]);			//H Int %
		CoolDataSorted[11] = (VAL[1]/TOT[1]);			//T Ext °C
		CoolDataSorted[12] = 1.8*(VAL[1]/TOT[1])+32;	//T Ext °F	
		CoolDataSorted[13] = (VAL[3]/TOT[1]);			//H Ext %
	}
	//RaZ:
	for(int i = 0; i < 2; i++)	{	TOT[i] = 0;	VAL[2*i] = 0; VAL[2*i + 1] = 0;	}
//Pompe:
	FirstData = FIRST_READ[4];
	boolean Suite = true;
	for(int i = 0; i < SENSOR[4]; i++)
	{
		Suite = Suite&&(CoolData[FirstData + i] > 0.0);
		CoolDataSorted[14] = Suite?1:0;
	}
	Suite = true;
//Ventilateurs:
	FirstData = FIRST_READ[5];
	for(int i = 0; i < SENSOR[5]; i++)
	{
		Suite = Suite&&(CoolData[FirstData + i] > 0.0);
		CoolDataSorted[15] = Suite?1:0;
	}
	Suite = true;
//Moisture:
//LEDS:
	FirstData = FIRST_READ[7];
	for(int i = 0; i < SENSOR[7]; i++)
	{
		Suite = Suite&&(CoolData[FirstData + i] > 0.0);
		CoolDataSorted[16] = Suite?1:0;
		VAL[0] += CoolData[FirstData + i];
		TOT[0] += 1;
	}
	CoolDataSorted[17] = map((VAL[0]/TOT[0]), 0, 255, 0, 100);
	for(int i = 0; i < 2; i++)	{	TOT[i] = 0;	VAL[2*i] = 0; VAL[2*i + 1] = 0;	}
//Capteurs Individuels:
	for(int i = 0; i < DataNumber; i++)	{	CoolDataSorted[i + 2*SENSOR_TYPE] = int(CoolData[i]);	}
}

void TreatCoolConfig()
{
	int[] Switch = new int[4];
	Switch[0] = int(COOL_CONFIG[1]);
	Switch[1] = int(COOL_CONFIG[Switch[0]+1]);
	Switch[2] = int(COOL_CONFIG[Switch[0]+Switch[1]+1]);
	Switch[3] = int(COOL_CONFIG[Switch[0]+Switch[1]+Switch[2]+1]);
	int[] Conf = new int[Switch[0]];
	int[] Timers = null;
	int[] Consignes = null;
	int[] Mode = null;
	for(int i = 0; i<Switch[0]; i++)  {  Conf[i] = int(COOL_CONFIG[i+1]);}
	if(Switch[1] != 0)
	{
		Timers = new int[Switch[1]];
		for(int i = Switch[0]+1; i<Switch[0] + Switch[1] + 1; i++)	{	Timers[i - Switch[0] -1] = int(COOL_CONFIG[i]);}
	}
	if(Switch[2] != 0)
	{
		Consignes = new int[Switch[2]];
		for(int i = Switch[0] + Switch[1] + 1; i < Switch[0] + Switch[1] + Switch[2] + 1; i++)	{	Consignes[i - Switch[0] - Switch[1]-1] = int(COOL_CONFIG[i]);	}
	}
	if(Switch[3] != 0)
	{
		Mode = new int[Switch[3]];
		for(int i = Switch[0] + Switch[1] + Switch[2] + 1; i < Switch[0] + Switch[1] + Switch[2] + Switch[3] + 1; i++)	{	Mode[i - Switch[0] - Switch[1] - Switch[2] - 1] = int(COOL_CONFIG[i]);	}
	}
	int j = 1;
	j = TreatBT(j, Conf);
	while(j<Conf.length){	j = TreatSensor(j, Conf);  }
	j = 1;
	if(Switch[1] != 0)	{	while(j<Timers.length)		{	j = TreatTimers(j, Timers);  }}
	print("\tTIMERS TRAITES -> "); println(j-1);
	j = 1;
	if(Switch[2] != 0)	{	while(j<Consignes.length)	{	j = TreatConsignes(j, Consignes);  }}
	print("\tCONSIGNES TRAITES -> "); println(j-1);
	j = 1;
	if(Switch[3] != 0)	{	while(j<Mode.length)	{	j = TreatMode(j, Mode);  }}
	print("\tMODES TRAITES -> "); println(j-1);
	DataNumber = 1;
	for(int i = 0; i<SENSOR_TYPE; i++)
	{
		FIRST_READ[i] = DataNumber-1;
		if(i == 0) DataNumber += 0;
		else if(i == 1) DataNumber += 6;
		else if(i == 3) DataNumber += 2*SENSOR[i];
		else if(i == 8) DataNumber += 0;
		else DataNumber += SENSOR[i];
	}
	CoolData = new float[DataNumber];
	SORTED_DATA = DataNumber+2*SENSOR_TYPE;
	CoolDataSorted = new float[SORTED_DATA];
	for(int k = 0; k<SORTED_DATA; k++)	{	CoolDataSorted[k] = 0.0;	}
	println("\tNumber of sent Data : " + DataNumber);
	MountFreePins();	
}

void MountFreePins()
{
//Remise a zero:
	for(int i = 2; i < 6; i++)	{	SENSNav_Buffer[i] = 0;	}
	for(int i = 0; i < 71; i++)	{	FREE_PINS[i] = true;	}
	for(int i = 0; i < 55; i++)	{	FREE_DIGITAL[i] = 0;	}
	for(int i = 0; i < 17; i++)	{	FREE_ANALOG[i] = 0;	}
	for(int i = 0; i < 9; i++)	{	FREE_UART[i] = 0;	}
	for(int i = 0; i < 12; i++)	{	FREE_PWM[i] = 0;	}
//Recuperation des pins utilises:
	for(int i = 0; i < SENSOR_TYPE; i++)
	{
		for(int j = 0; j < SENSOR[i]; j++)	{	FREE_PINS[PINS[i][j]] = false;		}
	}
//Tri par fonction:
	for(int i = 0; i < 71; i++)
	{
		if(FREE_PINS[i])
		{
			//UART:
			if((i < 2)||((i > 13)&&(i < 20)))
			{
				FREE_UART[0]++;
				FREE_UART[FREE_UART[0]] = i;
			}
			//PWM:
			else if((i > 2)&&(i < 14))
			{
				FREE_PWM[0]++;
				FREE_PWM[FREE_PWM[0]] = i;
			}
			//ANALOG:
			else if(i > 54)
			{
				FREE_ANALOG[0]++;
				FREE_ANALOG[FREE_ANALOG[0]] = i-54;
			}
			//DIGITAL:
			else if((i > 21)&&(i < 54))
			{
				FREE_DIGITAL[0]++;
				FREE_DIGITAL[FREE_DIGITAL[0]] = i;
			}
		}
	}
}

int TreatBT(int ptr, int[] Conf)
{
	int j = ptr;
	int Type = Conf[j++];
	SENSOR[Type] = Conf[j++];		//Lecture du type et du nombre
	PINS[Type] = new int[2];		//Lecture des pins
	PINS[Type][0] = Conf[j++];
	PINS[Type][1] = Conf[j++];
	int ParNum = Conf[j++];			//Lecture des parametres
	BTParams = new int[ParNum];
	for(int i = 0; i<ParNum; i++)	{	BTParams[i] = Conf[j++];	}
	int NameNum = Conf[j++];		//Lecture du Nom
	char[] Data = new char[NameNum];
	for(int i = 0; i<NameNum; i++)	{	Data[i] += char(Conf[j++]);	}
	BTName = new String(Data);
	int CodeNum = Conf[j++];		//Lecture du code
	BTCode = new int[CodeNum];
	for(int i = 0; i< CodeNum; i++)	{	BTCode[i] = Conf[j++];		}
	return j;
}

int TreatSensor(int ptr, int[] Conf)
{
	int j = ptr;
	int Type = Conf[j++];
	SENSOR[Type] = Conf[j++];
	if((Type != 8)&&(Type != 10))						//Pin Simple
	{
		PINS[Type] = new int[SENSOR[Type]];			//Lecture des pins
		for(int i = 0; i<SENSOR[Type]; i++)		{	PINS[Type][i] = Conf[j++];	}
	}
	else if(Type == 10)					//Camera
	{
		PINS[Type] = new int[2*SENSOR[Type]];		//Lecture des pins
		for(int i = 0; i<2*SENSOR[Type]; i++)	{	PINS[Type][i] = Conf[j++];	}
	}
	else if(Type == 8)					//Display
	{
		PINS[Type] = new int[10];
		for(int i = 0; i < 10; i++) {	PINS[Type][i] = 0; }
		if(SENSOR[Type] == 1)			//LedBar
		{
			PINS[Type][2] = Conf[j++];
			PINS[Type][3] = Conf[j++];
		}
		else if(SENSOR[Type] == 2)		//4-Digit + Bouton
		{
			PINS[Type][0] = Conf[j++];
			PINS[Type][1] = Conf[j++];
			PINS[Type][4] = Conf[j++];
		}
		if(SENSOR[Type] == 3)			//4-Digit + Bouton + LedBar
		{
			PINS[Type][0] = Conf[j++];
			PINS[Type][1] = Conf[j++];
			PINS[Type][2] = Conf[j++];
			PINS[Type][3] = Conf[j++];
			PINS[Type][4] = Conf[j++];
		}
	}
	return j;
}

int TreatTimers(int ptr, int[] Timers)
{
	int j = ptr;
	int len = Timers[0];
	while(j < len)
	{
		int Type = Timers[j++];
		int id = Timers[j++];
		long timer = 3600*Timers[j++] + 60*Timers[j++] + Timers[j++];
		TIMERS[Type][id] = timer;
	}
	return j;
}

int TreatConsignes(int ptr, int[] Consignes)
{
	int j = ptr;
	int i = 0;
	int len = Consignes[0];
	while(j < len)
	{
		int cons = Consignes[j++];
		COOL_CONSIGNES[i++] = cons;
	}	
	return j;
}

int TreatMode(int ptr, int[] Mode)
{
	int j = ptr;
	int len = Mode[0];
	while(j < len)
	{
		int type = Mode[j++];
		if(type == 0)	SENSOR_MODE[0][0] = Mode[j++];
		else if(type == 1)	SENSOR_MODE[1][0] = Mode[j++];
		else if((type == 2)||(type == 3)||(type == 5)||(type == 6))
		{
			for(int i = 0; i < SENSOR[type]; i++)
			{
				SENSOR_MODE[type][i] = Mode[j++];
				SENSOR_MODE[type][i+1] = Mode[j++];
			}
		}
		else if((type == 4)||(type == 7))
		{
			int test = (type == 7)?0:1;
			for(int i = 0; i < SENSOR[type]; i++)
			{
				SENSOR_MODE[type][2*i] = SENSOR_MODE[test][0];
				SENSOR_MODE[type][2*i+1] = Mode[j++];
			}
		}
	}
	return j;
}

void MakeCoolRequest(String[] Requests)
{
	Requests[0] = "?" + Requests[0] + "!\n";
	boolean[] Test = new boolean[3];
	String[] ToSend = {Requests[0], Requests[0]};
	for(int i = 0; i<3; i++ ) { Test[i] = false;  }
	CommBegin(Test[0], Requests[1], Requests[2]);
	CommBodySend(Test, Requests[0], Requests[3], Requests[4]);
	PetitCool.clear();
}

void WriteCoolAction(String Action)
{
//Initialisation:
	String[] Req = new String[5];
	Req[0] = Action;
	Req[1] = "R:A\n";
	Req[2] = "A:A";
	Req[3] = "R:O";
	Req[4] = "N:O";
	MakeCoolRequest(Req);
//Synchronisation:
	println("Commande Machine : " + Action);
		//PetitCoolStabiliseOrder();
	PetitCool.clear();
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/////////////////////FONCTIONS DE NAVIGATION APPLICATION///////////////////////
///////////////////////////////////////////////////////////////////////////////
void BotanicException_1(int PageNumber)
{
	if(NavMode.equals("Botanic"))
	{
		loadBotanicDBFromXML(PageNumber);
		return;
	}
}

void BotanicException_2(String TagName)
{
	if(TagName.equals("Botanic")) 
	{
		NavMode = "Botanic";
		CurrentPage = 0;
		loadBotanicDBFromXML(CurrentPage);
		println("Mode de Navigation : "+NavMode);
		return;
	}
}

void ChooseBackground(String BG)
{
	if((!BG.equals(CurrentBG))&(!BG.equals("")))
	{
		BackG = loadImage(BG);
		CurrentBG = BG;
	}
}

void ButtonLoadIco(String Ico, int Pos_Id)
{
	if(!Ico.equals(""))
	{
		CoolIcoOn[Pos_Id] = true;
		if(Ico.equals("SeasonMode"))
		{
			Ico = "Button\\Mode\\Season_";
			Ico += SENSOR_MODE[0][0];
			Ico += ".png";
		}
		if(Ico.equals("PumpMode"))
		{
			Ico = "Button\\Mode\\Pump_";
			Ico += SENSOR_MODE[1][0];
			Ico += ".png";
		}
		if(Ico.equals("IntLightMode"))
		{
			int Mode;
			if(NavMode.equals("NoMachine"))	Mode = 4;
			else	Mode = int(map(CoolDataSorted[6], 0, 100, 4, 0));
			Ico = "Button\\Mode\\LumInt_";
			Ico += Mode;
			Ico += ".png";
		}
		if(Ico.equals("GenLightMode"))
		{
			int Mode;
			if(NavMode.equals("NoMachine"))	Mode = 0;
			else	Mode = (CoolDataSorted[16] == 0.0)?0:1;
			Ico = "Button\\Control\\IO_Light_";
			Ico += Mode;
			Ico += ".png";
		}
		if(Ico.equals("GenPumpMode"))
		{
			int Mode;
			if(NavMode.equals("NoMachine"))	Mode = 0;
			else	Mode = (CoolDataSorted[14] == 0.0)?0:1;
			Ico = "Button\\Control\\IO_Pump_";
			Ico += Mode;
			Ico += ".png";
		}
		if(Ico.equals("GenFanMode"))
		{
			int Mode;
			if(NavMode.equals("NoMachine"))	Mode = 0;
			else	Mode = (CoolDataSorted[15] == 0.0)?0:1;
			Ico = "Button\\Control\\IO_Fans_";
			Ico += Mode;
			Ico += ".png";
		}
		if(Ico.equals("SensStatus"))
		{
			int Index;
			if(NavMode.equals("NoMachine")) Index = 0;
			else
			{
				Index = FIRST_READ[SENSNav_Buffer[0]];
				if(SENSNav_Buffer[0] == 3) Index += 2*SENSNav_Buffer[1];
				else Index += SENSNav_Buffer[1];
				Index = (CoolData[Index] == -1)?0:1;
			}
			Ico = "Button\\Control\\Sensor_";
			Ico += Index;
			Ico += ".png";
		}
		CoolIco[Pos_Id] = loadImage(Ico);
	}
	else CoolIcoOn[Pos_Id] = false;
}
	
void CountPageInteractions(XML PageToDisp)
{
	if(PageToDisp.getChild("Objects") != null)
	{
		XML[] TagToDisp = PageToDisp.getChild("Objects").getChildren("PageChange");
		if(TagToDisp != null)
		{
			parseNav();
			parseAction();
		}
	}
}

void loadPageFromXML(int PageNumber)
{
//Initialisation:
	XML[]  TagSelect;
	XML    PageToDisp, TagToDisp;
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		ModifyPage[i] = false;
		NextPages[i] = 0;
		PotOrders[i] = "";
		MouseOnZone[i] = false;
		CoolIcoOn[i] = false;
	}
	ClickedZone = false;
	Swap = false;
	NavCount = 0;
	ActionCount = 0;
//Recherche de la page a afficher:
	BotanicException_1(PageNumber);
	TagSelect = AppXML.getChildren("Page");
	PageToDisp = TagSelect[PageNumber];
	String TagName = PageToDisp.getString("Title");
	BotanicException_2(TagName);
//Lecture du fond d'ecran:
	String TaggedBG = PageToDisp.getChild("Background").getString("img");
	ChooseBackground(TaggedBG);
//Lecture des objets presents:
	TagToDisp = PageToDisp.getChild("Objects");
	if(TagToDisp != null)
	{
		TagSelect = PageToDisp.getChild("Objects").getChildren();
		for(int i = 0; i<TagSelect.length; i++)
		{
			TagToDisp = TagSelect[i];
			parsePageChange(TagToDisp);
			parseDateTime(TagToDisp);
			parseDataToDisp(TagToDisp);
			parseGraph(TagToDisp);
		}
	}
	//Parametres de Navigation:
	CountPageInteractions(PageToDisp);
}

void parsePageChange(XML TagToDisp)
{
	if(TagToDisp.getName().equals("PageChange"))
	{
		int Pos_Id = TagToDisp.getInt("pos");
		if(TagToDisp.hasAttribute("topage"))
		{
			if(TagToDisp.getInt("topage") > 0) NextPages[Pos_Id] = TagToDisp.getInt("topage");
			else
			{
				if(TagToDisp.getInt("topage") == -1)
				{
					switch(SENSNav_Buffer[0])
					{
						case 2:			//Luminosite
							NextPages[Pos_Id] = 20;
							break;
						case 3:			//DHT
							NextPages[Pos_Id] = 12;
							break;
						default:
							break;
					}
				}
			}
			ModifyPage[Pos_Id] = true;
			NavCount++;
		}
		if(TagToDisp.hasAttribute("action"))
		{
			NextPages[Pos_Id] = CurrentPage;
			PotOrders[Pos_Id] = TagToDisp.getString("action");
			ActionCount++;
		}
		String TagIco = TagToDisp.getString("ico");
		ButtonLoadIco(TagIco, Pos_Id);
		DisplayPageChange(Pos_Id);
		return;
	}
	else return;
}

void parseDateTime(XML TagToDisp)
{
	if(TagToDisp.getName().equals("DateTime"))
	{
		int Pos_Id = TagToDisp.getInt("pos");
		int FontSize = TagToDisp.getInt("fontsize");
		DisplayTime(Pos_Id, FontSize);
		return;
	}
	else return;
}

	void parseDataToDisp(XML TagToDisp)
{	//	Tester Ajout/Retrait Capteurs	MultiPins//
	if(TagToDisp.getName().equals("DataShow"))
	{
		int Pos_Id = TagToDisp.getInt("pos");
		int Font = TagToDisp.getInt("font");
		int FontSize = TagToDisp.getInt("fontsize");
		int Data_Id;
		String	FontColor = "FFFFFF";
		int Center = 0;
		String Data = "";
		String Text = "";
		boolean[] Test = {TagToDisp.hasAttribute("id"), TagToDisp.hasAttribute("text")};
		if(Test[0])
		{
			Data_Id = TagToDisp.getInt("id");
			if(!NavMode.equals("NoMachine")) 
			{
				//Consignes - Sensors Info - Timers - Modes:
				if(Data_Id < 0)	
				{
				//Mode Farenheit:	
					if(Data_Id == -107)	Data += int(1.8*COOL_CONSIGNES[6]+32);
				//Sensors Infos:	
					else if(Data_Id < -1000)
					{
						SENSNav_Buffer[0] = -Data_Id -1000;
						Data += int(SENSOR[SENSNav_Buffer[0]]);
					}
					else if((-999 <= Data_Id)&&(Data_Id <= -990))
					{
						long[]	TimeSever = new long[4];
						switch(-Data_Id - 990)
						{
							case 0:			//Selected Sensor
								Data += int(SENSNav_Buffer[1] + 1);
								break;
							case 1:			//Sensor's Pin:
								Data += int(PINS[SENSNav_Buffer[0]][SENSNav_Buffer[1]]);
								break;
							case 2:			//Sensors's Mode:
								if((SENSNav_Buffer[0] == 2)||(SENSNav_Buffer[0] == 3))
								{
									if(SENSOR_MODE[SENSNav_Buffer[0]][SENSNav_Buffer[1]] == 0) 		Data += "Internal";
									else if(SENSOR_MODE[SENSNav_Buffer[0]][SENSNav_Buffer[1]] == 1) Data += "External";
								}
								break;
							case 3:			//Sensor's Timer (h)
								TimeSever[0] = (TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])%3600;
								TimeSever[1] = ((TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])-TimeSever[0])/3600;
								TimeSever[3] = TimeSever[0]%60;
								TimeSever[2] = (TimeSever[0] - TimeSever[3])/60;
								Data += int(TimeSever[1]);
								break;
							case 4:			//Sensor's Timer (m)
								TimeSever[0] = (TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])%3600;
								TimeSever[1] = ((TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])-TimeSever[0])/3600;
								TimeSever[3] = TimeSever[0]%60;
								TimeSever[2] = (TimeSever[0] - TimeSever[3])/60;
								Data += int(TimeSever[2]);
								break;
							case 5:			//Sensor's Timer (s)
								TimeSever[0] = (TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])%3600;
								TimeSever[1] = ((TIMERS[SENSNav_Buffer[0]][SENSNav_Buffer[1]])-TimeSever[0])/3600;
								TimeSever[3] = TimeSever[0]%60;
								TimeSever[2] = (TimeSever[0] - TimeSever[3])/60;
								Data += int(TimeSever[3]);
								break;
							case 6:			//Sensor's Type (DHT Only : 11 - 22 - 44 - Uk)
								break;
							case 7:			//
								break;
							case 8:			//
								break;
							case 9:
								break;
							default:
								break;
						}
					}
				//Consignes:
					else
					{
						Data_Id = -Data_Id;
						Data += COOL_CONSIGNES[Data_Id-1];
					}
				}
				else if(Data_Id > 0)
				{
					if(CoolDataSorted[Data_Id] == -1) Data += "X";		//Gestion d'erreur
					else
					{
						if((CoolDataSorted[Data_Id] == -2)||(CoolDataSorted[Data_Id] <= -100))	Data += "N/C";		//Absence Capteur
						else Data += int(CoolDataSorted[Data_Id]);		//Capteur present et operationnel
					}
				}
				else if(Data_Id == 0)	Data += nfs(CoolDataSorted[3], 2, 0) + ":" + nfs(CoolDataSorted[4], 2, 0);
			}
			else
			{
				if(Data_Id < -1000)
				{
					SENSNav_Buffer[0] = -Data_Id -1000;
					Data += int(SENSOR[SENSNav_Buffer[0]]);
				}
				Data = "X";
			}
			if(!Test[1]) ActionCount++;
		}
		else Data_Id = -1;
		if(Test[1])
		{
			Text = TagToDisp.getString("text");
			if(TagToDisp.hasAttribute("color"))		FontColor = TagToDisp.getString("color");
			if(TagToDisp.hasAttribute("center"))	Center = TagToDisp.getInt("center");
			if(!Test[0]) ActionCount++;
		}
		if((!Data.equals(""))&&(!Text.equals(""))&&(!Data.equals("N/C"))&&(Data_Id != 0)&&(Data_Id != -1))	Data += Text;
		else if((!Data.equals(""))&&(!Text.equals(""))&&(Data_Id == 0)) Data = Text + Data;
		else if(Data.equals("")&&(!Text.contains("S:R"))&&(!Text.contains("S:A"))) Data = Text;
		else if(Text.contains("S:R"))
		{
			if(Text.equals("S:R:Set")) Data += SENSORLIST[SENSNav_Buffer[0]];
			else if(Text.equals("S:R:Nb"))  Data += (SENSOR[SENSNav_Buffer[0]] != 0)?SENSNav_Buffer[1]+1:"X";
			else if(Text.equals("S:R:Pin")) Data += (SENSOR[SENSNav_Buffer[0]] != 0)?PINS[SENSNav_Buffer[0]][SENSNav_Buffer[1]]:"X";
		}
		else if(Text.contains("S:A"))
		{
			if(Text.equals("S:A:Set")) Data += SENSORLIST[SENSNav_Buffer[0]];
			else if(Text.equals("S:A:Nb"))  Data += (!NavMode.equals("NoMachine"))?SENSOR[SENSNav_Buffer[0]] + 1:"X";
			else if(Text.equals("S:A:Pin"))
			{
				if((SENSNav_Buffer[0] == 0)||(SENSNav_Buffer[0] == 10))									//Uart
				{
					Data += (FREE_UART[0] != 0)?FREE_UART[SENSNav_Buffer[5]] + ", " + FREE_UART[SENSNav_Buffer[5] + 1]:"X";
				}
				else if((SENSNav_Buffer[0] == 2)||(SENSNav_Buffer[0] == 6))								//Analogique
				{
					Data += (FREE_ANALOG[0] != 0)?FREE_ANALOG[SENSNav_Buffer[4]]:"X";
				}
				else if((SENSNav_Buffer[0] == 3)||(SENSNav_Buffer[0] == 9))								//Digital
				{
					Data += (FREE_DIGITAL[0] != 0)?FREE_DIGITAL[SENSNav_Buffer[2]]:"X";
				}
				else if((SENSNav_Buffer[0] == 4)||(SENSNav_Buffer[0] == 5)||(SENSNav_Buffer[0] == 7))	//PWM
				{
					Data += (FREE_PWM[0] != 0)?FREE_PWM[SENSNav_Buffer[3]]:"X";
				}
			}
		}
		DisplayDataToShow(Data, Pos_Id, Font, FontSize, FontColor, Center);
		return;
	}
	else return;
}

void parseNav()
{
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		if(ModifyPage[i])	MouseOnZone[i] = MouseTest(i);
	}
	PageChange();
}

void parseAction()
{
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		if(!PotOrders[i].equals(""))	MouseOnZone[i] = MouseTest(i);
	}
	ActOnBiobot();
}

	boolean MouseTest(int Pos_Id)
{	//	ZONES CLIQUABLES	//
	int StatSize = int(WindowWidth/6.0);
	int DynSize = int(StatSize);
	int DynSize1 = int(54*DynRate);
	boolean Test = false;
	boolean[] Cond = new boolean[6];
	for(int i = 0; i < 6; i++)	{	Cond[i] = false;	}
	Cond[0] = (Pos_Id == 49)||(Pos_Id == 1)||(Pos_Id == 56)||(Pos_Id == 57);
	Cond[1] = (Pos_Id == 50)||(Pos_Id == 51)||(Pos_Id == 52)||(Pos_Id == 53)||(Pos_Id == 54)||(Pos_Id == 55)||(Pos_Id == 46)||(Pos_Id == 47)||(Pos_Id == 48)||(Pos_Id == 79)||(Pos_Id == 80)||(Pos_Id == 81)||(Pos_Id == 82)||(Pos_Id == 83)||(Pos_Id == 84)||(Pos_Id == 85);
	Cond[2] = (Pos_Id == 45);
	Cond[3] = (Pos_Id == 58)||(Pos_Id == 59)||(Pos_Id == 60)||(Pos_Id == 61)||(Pos_Id == 62)||(Pos_Id == 63)||(Pos_Id == 64);
	Cond[4] = (Pos_Id == 78);
	Cond[5] = (Pos_Id == 79);
	if(Cond[0])			Test = (mouseX < InteractiveZones[2*Pos_Id] + (4*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (4*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (DynSize)/2);
	else if(Cond[1])	Test = (mouseX < InteractiveZones[2*Pos_Id] + (2*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (2*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (DynSize)/2);
	else if(Cond[2])	Test = (mouseX < InteractiveZones[2*Pos_Id] + (6*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (6*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (DynSize1)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (DynSize1)/2);
	else if(Cond[3])	Test = (mouseX < InteractiveZones[2*Pos_Id] + (5*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (5*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (DynSize)/2);
	else if(Cond[4])	Test = (mouseX < InteractiveZones[2*Pos_Id] + (4*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (4*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (5*DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (5*DynSize)/2);
	else if(Cond[5])	Test = (mouseX < InteractiveZones[2*Pos_Id] + (5*DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (5*DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (3*DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (3*DynSize)/2);
	else 				Test = (mouseX < InteractiveZones[2*Pos_Id] + (DynSize)/2)&&(mouseX > InteractiveZones[2*Pos_Id] - (DynSize)/2)&&(mouseY > InteractiveZones[2*Pos_Id + 1] - (DynSize)/2)&&(mouseY < InteractiveZones[2*Pos_Id + 1] + (DynSize)/2);
	return Test;
}

void PageChange()
{
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		if(MouseOnZone[i]&&(ModifyPage[i]||(PotOrders[i].equals(""))))
		{
			NextPage = NextPages[i];
			ClickedZone = true;
			return;
		}
	}
	ClickedZone = false;
}

	void ActOnBiobot()
{	//	A COMPLETER	//
	for(int i = 0; i < TOTAL_DIVISION; i++)
	{
		if((MouseOnZone[i])&&(!PotOrders[i].equals("")))
		{
			OrderToSend = PotOrders[i];
			if((OrderToSend.equals("SEASON:MODE"))||(OrderToSend.equals("P:M"))||(OrderToSend.contains("C:TEMP"))||(OrderToSend.contains("C:HUM"))||(OrderToSend.contains("M:S"))||(OrderToSend.contains("SL:")))
			{
				NextPage = NextPages[i];
				Swap = true;
				return;
			}
			else
			{
				IsOrdered = true;
				return;
			}
		}
	}
	IsOrdered = false;
	Swap = false;
}

	void parseGraph(XML TagToDisp)
{	//EN COURS//
	if(TagToDisp.getName().equals("Graph"))
	{
		int Pos_Id = TagToDisp.getInt("pos");
		int Data_Id = -1;
		int Index = -1;
		String Color = "FFFFFF";
		boolean FarHt = false;
		boolean[] Test = {TagToDisp.hasAttribute("id"), TagToDisp.hasAttribute("mode")};
		if(Test[0])
		{
			Data_Id = TagToDisp.getInt("id");
			if(Data_Id < -1000)	//Donnees Moyennees et capteurs
			{
				SENSNav_Buffer[0] = -Data_Id -1000;
				if((SENSNav_Buffer[0] == 3)||(SENSNav_Buffer[0] == 9)) FarHt = ((Test[1])&&(TagToDisp.getString("mode").equals("F")));
				
			}
		}
		displayGraph(Data_Id, Pos_Id, Color, FarHt);
	}
	if(TagToDisp.getName().equals("Slider"))
	{
		int Pos_Id = TagToDisp.getInt("pos");
		int Data_Id = -1;
		int Index = -1;
		String[] Colors = new String[3];
		boolean FarHt = false;
		boolean Test = TagToDisp.hasAttribute("id")&&TagToDisp.hasAttribute("index");
		if(Test)
		{
			Data_Id = TagToDisp.getInt("id");
			if(TagToDisp.hasAttribute("color1")) Colors[0] = TagToDisp.getString("color1");
			else Colors[0] = "FFFFFF";
			if(TagToDisp.hasAttribute("color2")) Colors[1] = TagToDisp.getString("color2");
			else Colors[1] = "FFFFFF";
			if(TagToDisp.hasAttribute("color3")) Colors[2] = TagToDisp.getString("color3");
			else Colors[2] = "00AA00";
			//if(!NavMode.equals("NoMachine")) 
				Index += TagToDisp.getInt("index");
			if(Data_Id == 3) FarHt = ((Test)&&(TagToDisp.getString("mode").equals("F")));
		}
		if(TagToDisp.hasAttribute("action"))
		{
			NextPages[Pos_Id] = CurrentPage;
			PotOrders[Pos_Id] = TagToDisp.getString("action");
			ActionCount++;
		}
		displaySlider(Data_Id, Index, Pos_Id, Colors, FarHt);
	}
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/////////////////////ELEMENTS D'AFFICHAGE APPLICATION//////////////////////////
///////////////////////////////////////////////////////////////////////////////
	void displayGraph(int Data_Id, int Pos_Id, String Color, boolean Farenheit)
{	//	Graph Spectre OK	-	Autres Graphs a penser	//
//Initialisation:
	boolean Graphing = true;
	int StatSize = int(WindowWidth/6.0);
	int DynSize = int(StatSize);
	int GraphHeight;
	int GraphWidth;
	int GraphSampleNb = 0;
	int[] Graph_Xaxis = new int[2];
	int[] Graph_Yaxis = new int[2];
	String GraphStyle = "";
	String GraphColor = "";
	int[][] GraphData = new int[255][4];
//Mise a jour Taille:
	if(Pos_Id == 86)
	{
		GraphWidth = 4*DynSize;
		GraphHeight = 3*DynSize;
	}
	else
	{
		GraphWidth = 0;
		GraphHeight = 0;
	}
//Tri des donnees:
	if(Data_Id == 70)			//Spectre
	{
	//Recuperation des options graphiques:
		GraphStyle = "Rect";
		GraphColor = "Spectre";
		GraphSampleNb = 120;
		Graph_Xaxis[0] = 400;
		Graph_Xaxis[1] = 700;
		Graph_Yaxis[0] = 0;
		Graph_Yaxis[1] = 1;
	//Recuperation des donnees:
		float Temp;
		for(int i = 0; i < GraphSampleNb; i++)
		{
			/* Calcul de la hauteur */
			GraphData[i][3] = 0;
			Temp = 0;
			GraphData[i][0] = Graph_Xaxis[0] + ((i+1)*(Graph_Xaxis[1] - Graph_Xaxis[0])/(GraphSampleNb));
			for(int j = 0; j < 6; j++)
			{
				for(int k = 0; k < 3; k++)
				{
					Temp = (GraphData[i][0] - LedParamSpectrum[j][3*k+1])/LedParamSpectrum[j][3*k+2];		//(x - lambda_0[j, k])/sigma[j, k]
					Temp = 10*SENSOR_MODE[7][2*j+1]*LedParamSpectrum[j][3*k]*exp(-pow(Temp, 2));
					GraphData[i][3] += int(Temp);
				}
			}
			/* Scaling */
			GraphData[i][0] = int(map(GraphData[i][0], Graph_Xaxis[0], Graph_Xaxis[1], 0, GraphWidth));
			GraphData[i][3] = int(map(GraphData[i][3], 2550*Graph_Yaxis[0], 2550*Graph_Yaxis[1], 0, GraphHeight));
			/* Autres Parametres Rectangle(i) */			
			GraphData[i][3] = (GraphData[i][3] <= 1)?1:((GraphData[i][3] > GraphHeight)?GraphHeight:GraphData[i][3]);	//Hauteur
			GraphData[i][0] = InteractiveZones[2*Pos_Id] - (GraphWidth/2)*(1+(1/GraphSampleNb)) + GraphData[i][0];		//Centre : x
			GraphData[i][1] = InteractiveZones[2*Pos_Id+1] + (GraphHeight - GraphData[i][3])/2;							//Centre : y
			GraphData[i][2] = (GraphWidth/GraphSampleNb);																//Largeur
		}
	}
		else if(Data_Id == 3)		//Temperature
	{
	//Recuperation des options graphiques:
		GraphStyle ="Cont";
		GraphColor = Color;
		GraphSampleNb = 50;
		Graph_Xaxis[0] = -1;
		Graph_Xaxis[1] = -1;
		Graph_Yaxis[0] = 10;
		Graph_Yaxis[1] = 40;
	//Recuperation des donnees:
	}
//Trace:
	GraphTimer[0] = millis();
	Graphing = (GraphTimer[0] - GraphTimer[1] > UpdateGraph)||(Data_Id == 70);
	if(!Graphing) return;
	if(GraphStyle.equals("Rect"))
	{
	//Recuperation de la Couleur:
		float[] TempCol = new float[3];
		if(!GraphColor.equals("Spectre")) for(int i = 0; i < 3; i++) {	TempCol[i] = int((treatColor(GraphColor).split(":"))[i]);	}
	//Trace des rectangles:
		rectMode(CENTER);
		noStroke();
		for(int i = 0; i < GraphSampleNb; i++)
		{
			if(GraphColor.equals("Spectre")) for(int j = 0; j < 3; j++)
			{
				float lambda = Graph_Xaxis[0] + i*(Graph_Xaxis[1]-Graph_Xaxis[0])/GraphSampleNb;
				String[] ColorRGB = wavelength2rgb(lambda).split(":");
				TempCol[j] = float(ColorRGB[j]);
			}
			fill(TempCol[0], TempCol[1], TempCol[2]);
			rect(GraphData[i][0], GraphData[i][1], GraphData[i][2], GraphData[i][3]);
		}
	//Mise a jour Timer:
		GraphTimer[1] = GraphTimer[0];
	}
	else if(GraphStyle.equals("Cont"))
	{
		
	}
}

	void displaySlider(int SensType, int SensIndex, int Pos_Id, String[] Colors, boolean Farenheit)
{	//	Sliders Leds OK	-	Penser Autres Sliders	//
//Initialisation:
	int StatSize = int(WindowWidth/6.0);
	int DynSize = int(StatSize);
	int SliderHeight = 0;
	int[] SliderWidth = new int[2];
	int[] SliderOffset = new int[2];
	int[] TextPos = new int[3];
	int Pos = 0;
	int[] Corners = {0, 0};
//Mise a jour Taille:
	if((Pos_Id > 79)&&(Pos_Id < 83))
	{
		SliderHeight = int(0.25*DynSize);
		SliderWidth[0] = int(1.5*DynSize);
		SliderWidth[1] = int(0.15*DynSize);
		SliderOffset[0] = int(0.05*DynSize);
		SliderOffset[1] = int(0.1*DynSize/2);
		TextPos[0] = InteractiveZones[2*Pos_Id] - 3*DynSize/2;
		TextPos[1] = InteractiveZones[2*Pos_Id + 1];
		//Mise a jour Position:
		if((SensType != -1)&&(SensIndex != -1))
		{
			if(SensType == 7)
			{
				Pos = (InteractiveZones[2*Pos_Id] - SliderWidth[0]/2 - SliderOffset[0]) + int(map(SENSOR_MODE[SensType][2*SensIndex + 1], 0, 255, 0, SliderWidth[0]));
				TextPos[2] = int(map(SENSOR_MODE[SensType][2*SensIndex + 1], 0, 255, 0, 100));
			}
			else
			{
				Pos = (InteractiveZones[2*Pos_Id] - SliderWidth[0]/2 - SliderOffset[0]) + int(map(CoolData[FIRST_READ[SensType] + SensIndex], 0, 255, 0, SliderWidth[0]));
				TextPos[2] = int(map(CoolData[FIRST_READ[SensType] + SensIndex], 0, 255, 0, 100));
			}
		}
		else
		{
			Pos = InteractiveZones[2*Pos_Id] - SliderWidth[0]/2 - SliderOffset[0] + int(map(100, 0, 255, 0 ,SliderWidth[0]));
			TextPos[2] = int(map(100, 0, 255, 0 ,100));
		}
		Corners[1] = InteractiveZones[2*Pos_Id] - SliderWidth[0]/2;
		Corners[0] = Pos;
		//Mise a jour Ordre:
		if(!PotOrders[Pos_Id].equals("")) PotOrders[Pos_Id] += ":" + Pos_Id + ":LR:" + SliderWidth[0];
	}
	else if((Pos_Id > 82)&&(Pos_Id < 86))
	{
		SliderHeight = int(0.25*DynSize);
		SliderWidth[0] = int(1.5*DynSize);
		SliderWidth[1] = int(0.15*DynSize);
		SliderOffset[0] = int(0.05*DynSize);
		SliderOffset[1] = int(0.1*DynSize/2);
		TextPos[0] = InteractiveZones[2*Pos_Id] + 3*DynSize/2;
		TextPos[1] = InteractiveZones[2*Pos_Id + 1];
		//Mise a jour Position:
		if((SensType != -1)&&(SensIndex != -1))
		{
			if(SensType == 7)
			{
				Pos = (InteractiveZones[2*Pos_Id] + SliderWidth[0]/2 + SliderOffset[0]) - int(map(SENSOR_MODE[SensType][2*SensIndex +1], 0, 255, 0, SliderWidth[0]));
				TextPos[2] = int(map(SENSOR_MODE[SensType][2*SensIndex +1], 0, 255, 0, 100));
			}
			else
			{
				Pos = (InteractiveZones[2*Pos_Id] + SliderWidth[0]/2 + SliderOffset[0]) - int(map(CoolData[FIRST_READ[SensType] + SensIndex], 0, 255, 0, SliderWidth[0]));
				TextPos[2] = int(map(CoolData[FIRST_READ[SensType] + SensIndex], 0, 255, 0, 100));
			}
		}
		else
		{
			Pos = InteractiveZones[2*Pos_Id] + SliderWidth[0]/2 + SliderOffset[0] - int(map(100, 0, 255, 0 ,SliderWidth[0]));
			TextPos[2] = int(map(100, 0, 255, 0 ,100));
		}
		Corners[0] = Pos;
		Corners[1] = InteractiveZones[2*Pos_Id] + SliderWidth[0]/2;
		//Mise a jour Ordre:
		if(!PotOrders[Pos_Id].equals("")) PotOrders[Pos_Id] += ":" + Pos_Id + ":RL:" + SliderWidth[0];
	}
	else
	{
		for(int i = 0; i < 2; i++)
		{
			SliderHeight = 0;
			SliderWidth[i] = 0;
			SliderOffset[i] = 0;
		}
		//Mise a jour Position:
		if((SensType != -1)&&(SensIndex != -1)) Pos = InteractiveZones[2*Pos_Id] + int(map(CoolData[FIRST_READ[SensType] + SensIndex], 0, 255, 0, SliderWidth[0])/2);
		else Pos = InteractiveZones[2*Pos_Id] + SliderWidth[0]/2 + SliderOffset[0];
		TextPos[2] = 0;
		Corners[0] = InteractiveZones[2*Pos_Id];
		Corners[1] = Pos;
		//Mise a jour Ordre:
		if(!PotOrders[Pos_Id].equals("")) PotOrders[Pos_Id] += ":" + Pos_Id + "LR";
	}
//Recuperation Couleurs:
	int[] FontCol = new int[9];
	String Col = treatColor(Colors[0]);
	String[] TempCol = Col.split(":");
	for(int i = 0; i < 3; i++)	{	FontCol[i] = int(TempCol[i]);	}
	Col = treatColor(Colors[1]);
	TempCol = Col.split(":");
	for(int i = 0; i < 3; i++)	{	FontCol[i+3] = int(TempCol[i]);	}
	Col = treatColor(Colors[2]);
	TempCol = Col.split(":");
	for(int i = 0; i < 3; i++)	{	FontCol[i+6] = int(TempCol[i]);	}
//Trace:
	noStroke();
	//Contenant:
	rectMode(CORNER);
	fill(FontCol[0], FontCol[1], FontCol[2]);
	rect(InteractiveZones[2*Pos_Id] - SliderWidth[0]/2, InteractiveZones[2*Pos_Id + 1] - SliderHeight/2, SliderWidth[0], SliderHeight);
	//Remplissage:
	rectMode(CORNERS);
	fill(FontCol[6], FontCol[7], FontCol[8]);
	rect(Corners[0], InteractiveZones[2*Pos_Id + 1] + SliderHeight/2, Corners[1], InteractiveZones[2*Pos_Id + 1]);
	//Position:
	rectMode(CENTER);
	fill(FontCol[3], FontCol[4], FontCol[5]);
	rect(Pos, InteractiveZones[2*Pos_Id + 1], SliderWidth[1] + SliderOffset[0], SliderHeight + SliderOffset[1]);
	//Valeur:
	textFont(CoolFont[2], 12);
	textAlign(CENTER, CENTER);
	fill(255);
	text(TextPos[2], TextPos[0], TextPos[1]);
}

void BackGroundDisplay()
{
	background(0);
	imageMode(CENTER);
	image(BackG, WindowWidth/2, WindowHeight/2, WindowWidth, WindowHeight);
}

	void DisplayPageChange(int Pos_Id)
{	//	TAILLE IMAGE	-	REVOIR DYNAMISATION	-	TINT//
	if(CoolIcoOn[Pos_Id])
	{
		int StatSize = int(WindowWidth/6.0);
		int DynSize = int(StatSize);
		int DynSize1 = int(54*DynRate);
		boolean[] Cond = new boolean[6];
		for(int i = 0; i < 6; i++)	{	Cond[i] = false;	}
		Cond[0] = (Pos_Id == 49)||(Pos_Id == 1)||(Pos_Id == 56)||(Pos_Id == 57);
		Cond[1] = (Pos_Id == 50)||(Pos_Id == 51)||(Pos_Id == 52)||(Pos_Id == 53)||(Pos_Id == 54)||(Pos_Id == 55)||(Pos_Id == 46)||(Pos_Id == 47)||(Pos_Id == 48)||(Pos_Id == 65);
		Cond[2] = (Pos_Id == 45);
		Cond[3] = (Pos_Id == 58)||(Pos_Id == 59)||(Pos_Id == 60)||(Pos_Id == 61)||(Pos_Id == 62)||(Pos_Id == 63)||(Pos_Id == 64);
		Cond[4] = (Pos_Id == 78);
		Cond[5] = (Pos_Id == 79);
		imageMode(CENTER);
		if(TintIco[Pos_Id] != 0)	tint(TintIco[Pos_Id]);
		
		if(Cond[0])			image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 4*DynSize, DynSize);
		else if(Cond[1])	image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 2*DynSize, DynSize);
		else if(Cond[2])	image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 6*DynSize, DynSize1);
		else if(Cond[3])	image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 5*DynSize, DynSize1);
		else if(Cond[4])	image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 4*DynSize, 5*DynSize);
		else if(Cond[5])	image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], 5*DynSize, 3*DynSize);
		else 				image(CoolIco[Pos_Id], InteractiveZones[2*Pos_Id], InteractiveZones[2*Pos_Id + 1], DynSize, DynSize);
		
		noTint();
	}
}

void printPageChange()
{
	print("Changement vers Page ");
	if(NavMode.equals("Botanic"))
	{
		if(CurrentPage==99) println("0");
		else println("B"+CurrentPage);
		return;
	}
	else
	{
		if(CurrentPage==7) println("B0");
		else println(CurrentPage);
		return;
	}
}

void DisplayTime(int Pos, int FontSize)
{
	fill(0);
	noStroke();
	textFont(CoolFont[0], FontSize);
	textAlign(CENTER, CENTER);
	text(hour() + ":" + minute() + ":" + second(), InteractiveZones[2*Pos], InteractiveZones[2*Pos + 1]);
}

void DisplayDataToShow(int Data, int Pos, int FontNb, int FontSize)
{
	textFont(CoolFont[FontNb], FontSize);
	textAlign(CENTER, CENTER);
	fill(255);
	text(int(Data), InteractiveZones[2*Pos], InteractiveZones[2*Pos + 1]);
}

void DisplayDataToShow(String ToShow, int Pos, int FontNb, int FontSize, String Color, int Center)
{
	textFont(CoolFont[FontNb], FontSize);	
		int[] FontCol = new int[3];
		String Col = treatColor(Color);
		String[] TempCol = Col.split(":");
		for(int i = 0; i < 3; i++)	{	FontCol[i] = int(TempCol[i]);	}
	switch(Center)
	{
		case 0:
			textAlign(CENTER, CENTER);
			break;
		case 1:
			textAlign(LEFT, CENTER);
			break;
		default:
			textAlign(CENTER, CENTER);
			break;
	}
		fill(FontCol[0], FontCol[1], FontCol[2]);
	text(ToShow, InteractiveZones[2*Pos], InteractiveZones[2*Pos + 1]);
}

String treatColor(String FontColor)
{
	FontColor = (FontColor.charAt(0) == '#')?FontColor.substring(1,7):FontColor;
	String Result = "";
	int R = Integer.parseInt(FontColor.substring(0, 2), 16);
	int G = Integer.parseInt(FontColor.substring(2, 4), 16);
	int B = Integer.parseInt(FontColor.substring(4, 6), 16);
	Result += R;
	Result += ":";
	Result += G;
	Result += ":";
	Result += B;
	return Result;
}

String wavelength2rgb(float lambda)
{
	String	Result ="";
	float[] Color = new float[3];
	float	BrightCorr = 0;
	if((lambda >= 380)&&(lambda < 440))		//
	{
		Color[0] = -(lambda-440)/(440-350);
		Color[1] = 0;
		Color[2] = 1;
	}
	else if((lambda >= 440)&&(lambda < 490))		//
	{
		Color[0] = 0;
		Color[1] = (lambda-440)/(490-440);
		Color[2] = 1;
	}
	else if((lambda >= 490)&&(lambda < 510))		//
	{
		Color[0] = 0;
		Color[1] = 1;
		Color[2] = -(lambda-510)/(510-490);
	}
	else if((lambda >= 510)&&(lambda < 580))		//Vert - Jaune
	{
		Color[0] = (lambda-510)/(580-510);
		Color[1] = 1;
		Color[2] = 0;
	}
	else if((lambda >= 580)&&(lambda < 645))		//Orange - Rouge
	{
		Color[0] = 1;
		Color[1] = -(lambda-645)/(645-580);
		Color[2] = 0;
	}
	else if((lambda >= 645)&&(lambda < 780))		//Rouge lointain
	{
		Color[0] = 1;
		Color[1] = 0;
		Color[2] = 0;
	}
	else											//Hors Visible
	{
		Color[0] = 0; 
		Color[1] = 0;
		Color[2] = 0;
	}
//Correction de la saturation:
	if((lambda>=380)&&(lambda<420)) BrightCorr = 0.3+0.7*(lambda-350)/(420-350);
	else if((lambda>=420)&&(lambda<700)) BrightCorr = 1;
	else if((lambda>=700)&&(lambda<780)) BrightCorr = 0.3+0.7*(780-lambda)/(780-700);
	else BrightCorr = 0;
	BrightCorr *= 255;
//Preparation du resultat:
	Result += BrightCorr*Color[0];
	Result += ":";
	Result += BrightCorr*Color[1];
	Result += ":";
	Result += BrightCorr*Color[2];
	return Result;
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
////////////////////FONCTIONS DE NAVIGATION BDD BOTANIQUE//////////////////////
///////////////////////////////////////////////////////////////////////////////
	void loadBotanicDBFromXML(int PageNumber)
{  //OK//
//Initialisation:
  NavCount = 0;
  XML[]   NavTag;
  XML[]  TagSelect;
  XML    PageToDisp;
  XML    TagToDisp;
//Controle du mode de Navigation:
  if((NavMode.equals("Botanic"))&&(PageNumber != 99))
  {
    BotanicDB = loadXML("BotanicDB.xml");
  }
  else
  {
    NavMode = (ReadAbility)?"Connected":"NoMachine";
    CurrentPage = 0;
    println("Mode de Navigation : "+NavMode);
    return;
  }
//Recherche de la page a afficher:
  TagSelect = BotanicDB.getChildren("Page");
  PageToDisp = TagSelect[PageNumber];
//Lecture du fond d'ecran:
  String TaggedBG = PageToDisp.getChild("Background").getString("img");
  ChooseBackground(TaggedBG);

//Lecture des objets presents:
  if(PageToDisp.getChild("Objects")!=null)
  {
    TagSelect = PageToDisp.getChild("Objects").getChildren();
    for(int i = 0; i<TagSelect.length; i++)
    {
      TagToDisp = TagSelect[i];
      parsePageChange(TagToDisp);
      parseDateTime(TagToDisp);
      parseSearch(TagToDisp);
      parseTab(TagToDisp);
    }
  }
//Parametres de Navigation:
  int j = 0;
  NavTag = new XML[NavCount];
  //Balise PageChange:
  TagToDisp = PageToDisp.getChild("Objects").getChild("PageChange").getChild("UpPage");
  if((TagToDisp!=null)&&(TagToDisp.hasAttribute("topage")))
  {  
    NavTag[j] = TagToDisp;
    j++;
  }
  TagToDisp = PageToDisp.getChild("Objects").getChild("PageChange").getChild("DownPage");
  if((TagToDisp!=null)&&(TagToDisp.hasAttribute("topage")))
  {  
    NavTag[j] = TagToDisp;
    j++;
  }
  //Balise Menu:
  TagSelect = (PageToDisp.getChild("Objects").getChild("Menu")!=null)?PageToDisp.getChild("Objects").getChild("Menu").getChildren("Item"):null;
  if(TagSelect!=null)
  {    
    for(int i = 0; i<TagSelect.length; i++)
    {
      TagToDisp = TagSelect[i];
      if(TagToDisp.hasAttribute("topage"))
      {  
        NavTag[j] = TagToDisp;
        j++;
      }
    }
  }
  //Creation des interactions:
  if(j == NavCount) parseNav();
}

	void parseSearch(XML TagToDisp)
{  //OK//
	if(TagToDisp.getName().equals("SearchZone"))
	{
		int[] Pos = {TagToDisp.getInt("posX"), TagToDisp.getInt("posY")};
		int Size = TagToDisp.getInt("size");
		int[] FontSizes = {TagToDisp.getInt("fill"), TagToDisp.getChild("TextArea").getInt("fontsize"), TagToDisp.getChild("TextArea").getInt("color")};
		displaySearchArea(Pos, Size, FontSizes);
	}  
}

	void parseTab(XML TagToDisp)
{  //EN COURS  -  REVOIR POSITIONNEMENT ET ASSOCIATION DB//
	if(TagToDisp.getName().equals("Tableau"))
	{
	//Recherche de la plante
		XML[] Plants = BotanicDB.getChild("Plants").getChildren("Plante");
		XML SearchedPlant = null;
		for(int i = 0; i<Plants.length; i++)
		{
			SearchedPlant = (Plants[i].getString("name").equals(SearchBuffer))?Plants[i]:null;
			/* AUTRE TEST POSSIBLE:
			SearchedPlant = (match(SearchBuffer, Plants[i].getString("name"))!=null)?Plants[i]:null;
			*/
		}
	//Affichage des resultats:
		if(SearchedPlant!=null)
		{
		//Recuperation des donnees de recherche:
			String[] PlantInfo = new String[7];
			PlantInfo[0] = SearchedPlant.getString("name");
			PlantInfo[1] = SearchedPlant.getChild("Classification").getString("family");
			PlantInfo[2] = SearchedPlant.getChild("Classification").getString("order");
			PlantInfo[3] = SearchedPlant.getChild("Classification").getString("class");
			PlantInfo[4] = SearchedPlant.getChild("Classification").getString("division");
			PlantInfo[5] = SearchedPlant.getChild("Classification").getString("superdiv");
			PlantInfo[6] = SearchedPlant.getChild("Classification").getString("subking");
			//Generation du tableau:
			int[] PosTab = {TagToDisp.getInt("posX"), TagToDisp.getInt("posY")};
			XML[] Case = TagToDisp.getChildren("Case");
			int[] Pos = new int[2];
			int[] Size = new int[2];
			String[] Text = new String[2];
			int[] FontSizes = new int[2];
			for(int i = 0; i<Case.length; i++)
			{
			//Recuperation des informations graphiques:
				int line = Case[i].getInt("line");
				int col = Case[i].getInt("column");
				//Taille de l'element:
				if(Case[i].getString("symbol").equals("rect"))
				{
					Size[0] = Case[i].getInt("sizeX");
					Size[1] = Case[i].getInt("sizeY");
				}
				if(Case[i].getString("symbol").equals("square"))
				{
					Size[0] = Case[i].getInt("size");
					Size[1] = Case[i].getInt("size");
				}
				//Position de l'element:
				Pos[0] = PosTab[0]+(col-1)*Size[0];
				Pos[1] = PosTab[1]+(line-1)*Size[1];
				//Attributs de l'element:
				FontSizes[0] = Case[i].getChild("Text").getInt("fontsize");
				FontSizes[1] = Case[i].getChild("Text").getInt("color");
				Text[0] = Case[i].getChild("Text").getContent();
				Text[1] = PlantInfo[i];
			//Association des donnees de recherches:
				
			//Affichage
				displaySearchResults(Pos, Size, Text, FontSizes);
			}
		}
		else	displayNoResults();
	}
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//////////////////////ELEMENTS D'AFFICHAGE BOTANIQUE///////////////////////////
///////////////////////////////////////////////////////////////////////////////
	void displaySearchArea(int[] Pos, int Size, int[] FontSizes)
{  //OK//
//Zone de Saisie:
  rectMode(CENTER);
  fill(FontSizes[0]);
  noStroke();
  rect(Pos[0], Pos[1], Size, 3*FontSizes[1]/2);
//Parametre de Texte:
  textFont(CoolFont[0], FontSizes[1]);
  fill(FontSizes[2]);
//Curseur Insertion:
  String Text = Search;
  if((millis()-SearchBlink > 500)&&(millis()-SearchBlink < 1000))
  {
    Text += "_";
  }
  if(millis()-SearchBlink > 1000)
  {
    Text = Search;
    SearchBlink = millis();
  }
//Texte Saisi:  
  textAlign(LEFT, CENTER);
  text(Text, Pos[0]-Size/2, Pos[1]);
}

	void displaySearchResults(int[] Pos, int[] Sizes, String[] Text, int[] FontSizes)
{  //EN COURS  -  AJOUTER ACCES BDD//
//Affichage de la case:
  rectMode(CENTER);
  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(Pos[0], Pos[1], Sizes[0], Sizes[1]);
//Affichage des textes:
  textFont(CoolFont[0], FontSizes[0]);
  fill(FontSizes[1]);
  textAlign(LEFT, CENTER);
  text(Text[0], Pos[0]-Sizes[0]/2+FontSizes[0]/2, Pos[1]);
  text(Text[1], Pos[0]-Sizes[0]/2+FontSizes[0]/2, Pos[1]+FontSizes[0]);
}

	void displayNoResults()
{  //OK//
//Parametre de Texte:
  textFont(CoolFont[0], 36);
  fill(0);
//Message:
  String[] Text = {"Aucune Entree correspondante", "DESOLE!!!"};
//Affichage:
  textAlign(CENTER, CENTER);
  text(Text[0], 320, 240);
  text(Text[1], 320, 276);
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
