import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';

import 'enums.dart';

class AppString {
  static get appName => "Smart Gas Net";

  static const Map<Client, String> _releaseDates = {
    Client.mgl: "Version : 1.0.0 - MGL Steel - 11-06-2025",
    Client.pbgpl: "Version : 1.0.0 - PBGPL Steel - 11-06-2025",
    Client.unistal: "Version : 1.0.0 - Unistal Steel - 11-06-2025",
    Client.hpoil: "Version : 1.0.0 - HP OIL Steel - 19-02-2026",
    Client.vppl: "Version : 1.0.0 - VPPL Steel - 28-01-2026",
    Client.vrpl: "Version : 1.0.0 - VRPL Steel - 06-02-2026",
    Client.gjpl: "Version : 1.0.0 - GJPL Steel - 06-02-2026",
    Client.jdpl: "Version : 1.0.0 - JDPL Steel - 28-01-2026",
  };

  static String get version => _releaseDates[AppConfig.instanceInit()!.client] ?? "";

  static String companyName = "© Unistal Systems Pvt. Ltd.";

  static get googleApiKey => "AIzaSyAiFoe5ZuDbEVu0B3wyCrQsODy0lFQTxZ0";

  static get name => "Name";

  static get email => "Email";

  static get firstName => "First Name";

  static get lastName => "Last Name";

  static get emailPhoneNumber => "Email/Phone Number";

  static get login => "Login";

  static get phoneNumber => "Phone Number";

  static get password => "Password";

  static get confirmPassword => "Confirm Password";

  static get signup => "signup";

  static get signIn => "Sign in";

  static get doesNotHaveAccount => "Does not have account?";

  static get continueToSignup => "Continue To Sign up";

  static get enterOtp => "Enter OTP";

  static get resendOtp => "Resend OPT?";

  static get verify => "Verify";

  static get submit => "Submit";

  static get addItem => "Add Item";

  static get ok => "Ok";

  static get request => "Request";

  static get running => "Running";

  static get requests => "Requests";

  static get cancel => "Cancel";

  static get logout => "Logout";

  static get dashboard => "Dashboard";

  static get systemAdmin => "System Admin";

  static get serviceCenter => "Service Center";

  static get changePassword => "Change Password";

  static get selectProductType => "Select Product Type";

  static get selectCategory => "Select Category";

  static get selectState => "Select State";

  static get selectProduct => "Select Product";

  static get region => "Region";

  static get customerNameOrganisation => "Customer Name/Organisation";

  static get customerAddress => "Customer Address";

  static get jobDetail => "Job Detail";

  static get serviceUndertaken => "Service  Undertaken At";

  static get complaintReceivedMode => "Complaint received mode";

  static get customerEmailId => "Customer Email Id";

  static get date => "Date";

  static get city => "City";

  static get contactPerson => "Contact Person";

  static get contactNumber => "Contact Number";

  static get callStatus => "Call Status";

  static get service => "Service";

  static get installation => "Installation";

  static get refurbishment => "Refurbishment";

  static get aisc => "AISC";

  static get asfSite => "ASF Site";

  static get userSite => "User Site";

  static get phoneCall => "Phone Call";

  static get walkin => "Walkin";

  static get byPost => "By Post";

  static get setSerialNumberImeiNumber => "Set S.N./IMEI No.";

  static get model => "Model";

  static get purchaseDate => "Purchase Date";

  static get manufacturingDate => "Manufacturing Date";

  static get expectedDate => "Expected Date";

  static get selectCustomerComplaint => "Select Customer Complaint";

  static get selectSegment => "Select Segment";

  static get selectCrossingType => "Select Crossing Type";

  static get defectWelder => "Defect Welder";

  static get defectLayer => "Defect Layer";

  static get defectType => "Defect Type";

  static get defectLocation => "Defect Location";

  static get autStatus => "Aut Status";

  static get routeSurvey => "Route Survey";

  static get clearingGrading => "Clearing & Grading";

  static get reportNumber => "Report Number";

  static get preHeatTemperature => "Preheat Temperature";

  static get onWeld => "On Weld";

  static get chainageFrom => "Chainage From";

  static get sectionLengthMeter => "Section Length(Meter)";

  static get casingPipeLengthMeter => "Casing Pipe Length(Meter)";

  static get pipeLength => "Pipe Length";

  static get hdpeLayingLength => "HDPE Laying Length(Meters)";

  static get chainageTo => "Chainage To";

  static get sectionLength => "Section Length";

  static get pressureGaugeNo => "Pressure Gauge No";

  static get pressureGaugeCalibrationDate => "Pressure Gauge Calibration Date";

  static get testPressure => "Test Pressure";

  static get range => "Range";

  static get pipeSize => "Pipe Size";

  static get duration => "Duration";

  static get timeOn => "Time On";

  static get timeOff => "Time Off";

  static get timeInHours => "Time In Hours";

  static get pressureReading1Kg => "Pressure Reading 1(Kg/Cm)";

  static get pressureReading2Kg => "Pressure Reading 2(Kg/Cm)";

  static get temp => "Temp";

  static get casingPipeLength => "casing Pipe Length(Meters)";

  static get hydrotestingLength => "Hydrotesting Length(Meter)";

  static get hdpeLayinglength => "HDPE Laying Length(Meters)";

  static get ndeClearance => "NDE/ UT Clearance";

  static get ductCleaning => "Duct Cleaning";

  static get ductIntegrityTest => "Duct Integrity Test";

  static get airPressureTest => "Air Pressure Test";

  static get gpsCoordinateNorth => "GPS Coordinate Northing";

  static get captureGPS => "Capture GPS ";

  static get northing => "Northing";

  static get easting => "Easting";

  static get gpsCoordinateEast => "GPS Coordinate Easting";

  static get elevationPipeTop => "Elevation/Pipetop";

  static get naturalGroundLeve => "Natural Ground Level";

  static get cover => "Cover";

  static get topCover => "Top Cover";

  static get pipeCover => "Pipe Cover";

  static get levelling => "Levelling";

  static get srNoSplicingMachine => "S.No Splicing Machine";

  static get postPadding => "Post Padding";

  static get batchNo => "Batch No";

  static get length => "Length";

  static get surface => "Surface";

  static get drying => "Drying";

  static get landType => "Land Type";

  static get lengthMeter => "Length(Meters)";

  static get couplerEndCapJointPit => "Coupler/End Cap/Joint Pit";

  static get pitNumber => "Pit Number";

  static get slopBreaker => "Slope Breaker";

  static get warningMat => "Warning Mat";

  static get antiBuoyancy => "Anti Buoyancy";

  static get selectPlasticGrating => "Select Plastic Grating";

  static get selectRemovalOfSurplusMaterialData =>
      "Select Removal Of Surplus Material";

  static get selectReplacementofTopSoilData => "Select Replacement of Top Soil";

  static get selectReinstallationBoundaryStonesData =>
      "Select Reinstallation Boundary Stones";

  static get selectWarningMatMeter => "Select Warning Mat Meter";

  static get selectPaddingMeter => "Select Padding Meter";

  static get tpFrom => "IP From";

  static get bendAngleTpNumber => "Bend Angle TP Number";

  static get typeofGround => "Type of ground";

  static get tpTo => "IP To";

  static get radiography => "Radiography";

  static get ndtRT => "NDT RT";

  static get tiein => "Tie In";

  static get totalWeldJoints => "Total Weld Joints";

  static get dpt => "DPT";

  static get hindrance => "Hindrance";

  static get ofcFinalTesting => "OFC Final Testing";

  static get svInstallation => "SV Installation";

  static get ipInstallation => "IP Installation";

  static get ndtMut => "NDT Mut";

  static get ndtAut => "NDT Aut";

  static get jointCoating => "Joint Coating";

  static get concreteCoating => "Concrete Coating";

  static get lpt => "LPT";

  static get ndtLpt => "NDT LPT";

  static get bendAngleDegree => "Bend Angle Degree";

  static get bendNumber => "Bend Number";

  static get ipNoFrom => "IP No. From";

  static get ipNoTo => "IP Number To";

  static get tpRemark => "TP Remark";

  static get bendAngleMinute => "Bend Angle Minute";

  static get groundType => "Ground Type";

  static get bearingAngle => "Bearing Angle";

  static get bendAngleSecond => "Bend Angle Second";

  static get structureName => "Structure Name";

  static get terrain => "Terrain";

  static get structureLocation => "Structure Location";

  static get boundaryLocation => "Boundary Location";

  static get location => "Location";

  static get holidayDetectorDetails => "Holiday Detector Details";

  static get makeModel => "Make/Model";

  static get primerABatch => "Primer A Batch";

  static get concreteCoatingLengthMeter => "Concrete Coating Length(Meter)";

  static get primerBBatch => "Primer B Batch";

  static get holidayTestNo => "Holiday Tester No";

  static get ofcDrumNoPlusDirection => "Ofc Drum No.(+ve Direction)";

  static get ofcDrumNoMinusDirection => "Ofc Drum No.(-ve Direction)";

  static get cableReadingPlusDirection => "Cable Reading (+ve Direction)";

  static get cableReadingMinusDirection => "Cable Reading (-ve Direction)";

  static get testVoltage => "Test Voltage";

  static get add => "Add";

  static get calibarationDate => "Calibaration Date";

  static get onBody => "On Body";

  static get repairCoatingDamage => "Repair Of Coating Damage";

  static get electrometerNo => "Electrometer No";

  static get activityRemark => "Activity Remark";

  static get filmType => "Film Type";

  static get inspectionTechnique => "Inspection Technique";

  static get sensivity => "Sensivity";

  static get density => "Density";

  static get equipment => "Equipment";

  static get observationResult => "Observation/Results";

  static get locationOfDiscoveredDefect => "Location Of Discovered Defects";

  static get selectAlignment => "Select Alignment";

  static get soilResistivity => "Soil Resistivity";

  static get rouHandover => "Rou Handover";

  static get fromJointId => "From Joint Id";

  static get toJointId => "To Joint Id";

  static get trenchingDepth => "Trenching Depth";

  static get terrainType => "Terrain Type";

  static get widthMeter => "Width(Meters)";

  static get trenChing => "Trenching";

  static get stringing => "Stringing";

  static get selectPipeNumber => "Enter Pipe Number";

  static get selectLeftPipeNumber => "Select Left Pipe Number";

  static get selectRightPipeNumber => "Select Right Pipe Number";

  static get selectConcreteCoating => "Select Concrete Coating";

  static get selectVisualChecks => "Select Visual Checks";

  static get selectGaugingChecks => "Select Gauging Checks";

  static get selectDisbomdmentChecks => "Select Disbomdment Checks";

  static get selectHolidayChecks => "Select Holiday Checks";

  static get selectWeather => "Select Weather";

  static get selectNdtAgency => "Select NDT Agency";

  static get selectDSPPL => "Select DSPPL";

  static get selectMECONPBGPL => "Select MECON/PBGPL";

  static get selectTerrain => "Select Terrain";

  static get selectCoatingType => "Select Coating Type";

  static get sleeveType => "Sleeve Type";

  static get selectPeelTest => "Select Peel Test";

  static get selectPrePadding => "Select Pre Padding";

  static get selectPostPadding => "Select Post Padding";

  static get selectPipeDia => "Select Pipe Dia";

  static get selectPipeMaterial => "Select Pipe Material";

  static get selectPipeThickness => "Select Pipe Thickness";

  static get selectGroundType => "Select Ground Type";

  static get selectBendingType => "Select Bending Type";

  static get chainage => "Chainage";

  static get cutPipeLength => "Cut Pipe Length";

  static get bending => "Bending";

  static get welding => "Welding";

  static get marker => "Marker Installation";

  static get weldRepair => "Weld Repair";

  static get backFilling => "BackFilling";

  static get crossing => "Crossing";

  static get crossingName => "Crossing Name";

  static get hdpeDuctLaying => "HDPE Duct Laying";

  static get hdpeDuctTesting => "HDPE Duct Testing";

  static get lowering => "Lowering";

  static get ofcSplicing => "OFC Splicing/Jointing";

  static get ofcBlowing => "OFC Blowing";

  static get postHydrotest => "Post Hydrotest";

  static get preHydrotest => "Pre Hydrotest";

  static get hydrotest => "Hydrotest";

  static get restoration => "Restoration";

  static get swabbing => "Swabbing";

  static get restore => "Restore";

  static get concreteCoatingThickness => "Concrete Coating Thickness";

  static get wallThickness => "Wall Thickness";

  static get concreteCoatingLength => "Concrete Coating Length";

  static get cutPipe => "Cut Pipe";

  static get selectJointType => "Select Joint Type";

  static get preHeatingTemperature => "Pre Heating Temperature";

  static get selectJointNumber => "Select Joint Number";

  static get selectRtSource => "Select RT Source";

  static get selectRepairStatus => "Select Repair Status";

  static get selectLptStatus => "Select Lpt Status";

  static get selectFromJointNumber => "Select From Joint Number";

  static get selectMarkerType => "Marker Type";

  static get selectToJointNumber => "Select To Joint Number";

  static get selectWPS => "Select WPS";

  static get selectWelder => "Select Welder";

  static get welder1 => "Welder 1";

  static get welder2 => "Welder 2";

  static get leftPipeNumber => "Left Pipe Number";

  static get rightPipeNumber => "Right Pipe Number";

  static get rootWelders1 => "Root Welder 1";

  static get rootWelders => "Root Welder";

  static get rootWelders2 => "Root Welder 2";

  static get hotWelders => "Hot Welder";

  static get hotWelders1 => "Hot Welder 1";

  static get hotWelders2 => "Hot Welder 2";

  static get fillerWelders1 => "Filler Welders 1";

  static get fillerWelders2 => "Filler Welders 2";

  static get fillerWelders => "Filler Welders";

  static get filler1Welders1 => "Filler 1 Weldrs 1";

  static get filler1Welders2 => "Filler 1 Welders 2";

  static get filler2Welders1 => "Filler 2 Welders 1";

  static get filler2Welders2 => "Filler 2 Welders 2";

  static get filler3Welders1 => "Filler 3 Welders 1";

  static get filler3Welders2 => "Filler 3 Welders 2";

  static get filler4Welders1 => "Filler 4 Welders 1";

  static get filler4Welders2 => "Filler 4 Welders 2";

  static get filler5Welders1 => "Filler 5 Welders 1";

  static get filler5Welders2 => "Filler 5 Welders 2";

  static get filler6Welders1 => "Filler 6 Welders 1";

  static get filler6Welders2 => "Filler 6 Welders 2";

  static get filler7Welders1 => "Filler 7 Welders 1";

  static get filler7Welders2 => "Filler 7 Welders 2";

  static get filler8Welders1 => "Filler 8 Welders 1";

  static get filler8Welders2 => "Filler 8 Welders 2";

  static get selectFitup => "Select Fitup";

  static get selectWeldVisual => "Select Weld Visual";

  static get stripWelder1 => "Strip Welder1";

  static get stripWelder2 => "Strip Welder2";

  static get cappingWelder => "Capping Welder";

  static get cappingWelder1 => "Capping Welder 1";

  static get cappingWelder2 => "Capping Welder 2";

  static get electrodeDiaE6010 => "Electrode Dia E6010";

  static get electrodeDiaE6010Batch => "Electrode E6010 Batch";

  static get electrodeDiaE8010p1 => "Electrode Dia E8010P1";

  static get electrodeDiaE7010P1 => "Electrode Dia E7010P1";

  static get electrodeDiaE8010p1Batch => "Electrode Dia E8010P1 Batch";

  static get electrodeDiaE7010P1Batch => "Electrode E7010P1 Batch";

  static get electrodeDiaE9045p2 => "Electrode Dia E9045P2";

  static get electrodeDiaE9045p2Batch => "Electrode Dia E9045P2 Batch";

  static get electrodeDiaE81t8g => "Electrode Dia E8118G";

  static get electrodeDiaE81t8gBatch => "Electrode Dia E8118G Batch";

  static get typeOfFlawDetector => "Type Of Flaw Detector";

  static get angleOfRayInput => "Angle Of Ray Input";

  static get operatingFrequency => "Operating Frequency";

  static get levelOfInspection => "Level of Inspection";

  static get latitude => "Latitude";

  static get longitude => "Longitude";

  static get detailOfGap => "Details Of Gap";

  static get description => "Description";

  static get logoutMessage =>
      "Are you sure you want to logout? Once you logout, you will be return to login screen";

  static get hdd => "HDD";

  static get pilotDrill => "Drilling";

  static get hddReaming => "Reaming";

  static get hddBore => "HDD Bore";

  static get hddCleanPass => "HDD Clean Pass";

  static get hddPulling => "HDD Pulling";

  static get hddCrossing => "HDD Crossing";

  static get gauging => "Gauging";

  static get molling => "Molling";

  static get tcp => "TCP";

  static get testStationBoxes => "Test Station Boxes";

  static get sacrificialAnode => "COMMISSIONING OF SACRIFICIAL ANODES";

  static get groundingAnode => "ZN GROUNDING ANODE/CELL";

  static get installationCables => "INSTALLATION OF CABLES";

  static get mgAnodeInstallation => "Mg Anode Installation";

  static get anodeBedInstallation => "PCP Anode Bed Installation";

  static get cableLaying => "Cable Laying";

  static get thermitWelding => "Thermit Welding";

  static get pinBrazzing => "Pin Brazzing";

  static get ssd => "SSD";

  static get surgeDiverter => "Surge Diverter";

  static get polarisationCoupan => "Polarisation Coupan";

  static get tcpMonitoringReport => "TCP Monitoring Report";

  static get selectFromJoint => "Select From Joint";

  static get selectToJoint => "Select To Joint";

  static get selectStartDateOfPilotHole => "Start Date Of Pilot Hole";

  static get selectEndDateOfPilotHole => "End Date Of Pilot Hole";

  static get selectStartDateReaming => "Start Date Of Reaming";

  static get selectEndDateOfReaming => "End Date Of Reaming";

  static get selectStartDateCleanPass => "Start Date Of Cleanpass";

  static get selectEndDateCleanPass => "End Date Of Cleanpass";

  static get selectStartDatePulling => "Start Date Of Pulling";

  static get selectEndDatePulling => "End Date Of Pulling";

  static get selectHDDMachineCapacity => "HDD Machine Capacity";

  static get selectSizeReaming => "Size Of Reaming(Max)";

  static get selectSizeCleanPass => "Size Of Cleanpass";

  static get selectSizePulling => "Size Of Pulling";

  static get selectReamerSize => "Reamer Size";

  static get selectSizePilotBitSize => "Size of Pilot & Bit Size";

  static get selectLength => "Length";

  static get selectLengthCrossing => "Length of Crossing";

  static get selectRodNo => "Rod No";

  static get selectTotalLength =>
      "Total % Length from Entry point to pilot (mtr.)";

  static get selectTotalReamingLength =>
      "Total Reaming Length from Exit point to pilot (Mtr.)";

  static get selectPitch => "Pitch (%)";

  static get selectDegree => "Degree";

  static get selectDepth => "Depth (Mtr.)";

  static get selectRigLoad => "Rig output Load";

  static get selectPullBackPressure => "Pull back Pressure(PSI)";

  static get selectRotaryPressure => "Rotary Pressure(PSI)";

  static get selectPumpRate => "Pump Rate(GPM)";

  static get selectStartingDatePulling => "Starting Date Of Pulling";

  static get selectEndingDatePulling => "Ending Date Of Pulling";

  static get selectEquipmentCapacity => "Equipment Capacity";

  static get selectEquipmentUsed => "Equipment Used";

  static get selectDateCommencement => "Date Of Commencement";

  static get selectDateCompletion => "Date of Completion";

  static get selectDatePreHydro => "Date of Pre-Hydro test";

  static get selectPipeSpecification => "Pipe Specification";

  static get selectPipeODThickness => "Pipe OD x Thickness";

  static get selectHddLocation => "HDD Location";

  static get selectPipeBoreDetails => "Pilot Bore Details";

  static get selectBoreStartTime => "Pilot Bore Start time";

  static get selectPilotBoreCompleted => "Pilot Bore Completed time";

  static get selectPilotBoreDiameter => "Pilot Bore Diameter";

  static get selectDuration => "Duration(Hrs)";

  static get selectReamerSizeUsed => "Reamer Size Used";

  static get selectStart => "Start";

  static get selectEnd => "End";

  static get selectReamingOperation => "Reaming Operation";

  static get selectLoadObservedPSI => "Load Observed PSI";

  static get selectTLPType => "TLP Type";

  static get selectArea => "Area";

  static get selectTestLocation => "Test station Location (Chainage in Km)";

  static get selectAnodeLocation => "Anode Location (Chainage in Km)";

  static get selectTestType => "Test Station Type and No";

  static get selectDistance => "Distance from the pipeline (m)";

  static get selectFoundation => "Foundation check(As per drawing)";

  static get selectMounting => "Test Station Mounting (As per drawing)";

  static get selectDoors => "Test station Doors/ Locks/ Gasket";

  static get selectCable => "Cable entry sealing";

  static get selectTermination => "Cable Termination and ferruling check";

  static get selectNamePlate => "Name plate & connection scheme diagram check";

  static get selectIndividual =>
      "Individual resistor & shunt value check at Mg anode Location";

  static get selectCompaction => "Compaction & Alignment";

  static get selectCableSealing => "Cable sealing";

  static get selectTestStation => "Test Station No";

  static get selectSacrificialAnode => "Type of Sacrificial Anode";

  static get selectAnode => "No. of Anodes";

  static get selectSpacingAnode => "Spacing Between Anodes";

  static get selectOutputAnode => "Current Output of Anode";

  static get selectAnodeCondition =>
      "Anode Condition & Anode Laying & Termination with Test station";

  static get selectAnodeTail => "Anode Tail Cable Length(mtr)";

  static get selectA1 => "A1";

  static get selectA2 => "A2";

  static get selectA3 => "A3";

  static get selectA4 => "A4";

  static get selectAnodeCircuit =>
      "Anode Open circuit potential w.r.t Cu/CuSO4 Ref. Cell";

  static get selectBeforePSP =>
      "PSP w.r.to Cu/CuSO4 Ref. Cell (Before Connecting Anode)";

  static get selectAfterPSP =>
      "PSP w.r.to Cu/CuSO4 Ref. Cell (After Connecting Anode)";

  static get selectTypeAnode => "Type of anode";

  static get selectAnodeWeight => "Anode Weight/length";

  static get selectDepthAuger => "Depth of Auger Hole / Excavation";

  static get selectNoAnode => "No of Anodes & Spacing between anodes";

  static get selectEarthingResistance => "Earthing Resistance";

  static get selectACPSPBefore => "AC PSP before connecting earthing";

  static get selectDCPSPAfter => "AC current after installation of earthing";

  static get selectACPSPAfter => "DC PSP after connecting anodes";

  static get selectDCPSPBefore => "DC PSP before connecting anodes";

  static get selectInstallationType =>
      "Installation Type (Vertical/Horizontal)";

  static get selectCheckWater =>
      "Check water filling during backfilling, cable termination, laying & backfilling odf soil";

  static get selectCableSize => "Cable size & length";

  static get selectCableTrench => "Cable trench";

  static get selectDepthLaying => "Depth of laying";

  static get selectSand => "Sand / brick spreading";

  static get selectWarning => "Warning mat placement";

  static get selectBackfilling => "Backfilling/ restoration";

  static get selectTagging => "Tagging/ Ferruling";

  static get selectRoute => "Route Marking (at 2m)";

  static get selectIR => "IR value of cable (>2mΩ)";

  static get selectSpacingConnection => "Spacing between connection";

  static get selectCableResistance => "Cable to pipe contact resistance";

  static get selectEpoxy => "Epoxy & Hardner Filling";

  static get selectCableLength => "Cable length (in m)";

  static get selectPinBrazing => "Pin Brazing Connection";

  static get selectContinuityCheck => "Continuity Check";

  static get selectRestorationCheck => "Restoration Check";

  static get selectVoltageRating => "Voltage rating of HT line";

  static get selectHTTower =>
      "HT tower footing distance from Pipeline both side and crossing angle";

  static get selectInstallation =>
      "Installation of Polarization cell in test station, Proper fitting and tightness check";

  static get selectCableTermination => "Cable Termination, Fer-ruling check";

  static get selectCheckACVol =>
      "Check AC voltage before and after connecting polarisation cell";

  static get selectPSP => "PSP w.r.t. reference cell";

  static get selectFinalRestoration => "Final Restoration";

  static get selectNoSurgeDiverter => "Sr No. Of Surge Diverted";

  static get selectInstallSurgeDiverter => "Installation. Of Surge Diverted";

  static get selectCableConnection => "Cable Connection";

  static get selectPSPReadingProtection =>
      "PSP Reading of Protection Section(mV)";

  static get selectPSPReadingOther => "PSP Reading of Other Section(mV)";

  static get selectPolarityCheck => "Polarity Check";

  static get selectBackfillRestoration => "Back-fill & Restoration";

  static get selectCorrosion =>
      "Corrosion Coupon condition (back-fill, cable, bag)";

  static get selectDistanceMM => "Distance from pipeline(mm)";

  static get selectCableTerminationTest => "Cable termination at Test Station";

  static get selectPSPMeasurement => "PSP measurement With permanent(mV)";

  static get selectCouponInstant => "Coupon Instant OFF potential(V)";

  static get selectDigitalMultimete => "Digital Multimeter";

  static get selectModelNo => "Model No.";

  static get selectMake => "Make";

  static get selectDateCalibration => "Date of Calibration";
}
