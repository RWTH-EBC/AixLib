within AixLib.DataBase.Media.Refrigerants.R1270;
record EoS_Sangi "Record with fitting coefficients taken from the Fast_Propane
    model"
  import AixLib;
  extends
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from FastPropane model developed by Sangi et al.",
    alpha_0_nL=1,
    alpha_0_l1={3},
    alpha_0_l2={1},
    alpha_0_nP=2,
    alpha_0_p1={-4.970583,4.29352},
    alpha_0_p2={0,1},
    alpha_0_nE=4,
    alpha_0_e1={3.043,5.874,9.337,7.922},
    alpha_0_e2={-1.062478,-3.344237,-5.363757,-11.762957},
    alpha_r_nP=5,
    alpha_r_p1={0.042910051,1.7313671,-2.4516524,0.34157466,-0.46047898},
    alpha_r_p2={4,1,1,2,2},
    alpha_r_p3={1,0.33,0.80,0.43,0.90},
    alpha_r_nB=6,
    alpha_r_b1={-0.66847295,0.20889705,0.19421381,-0.22917851,-0.60405866,0.066680654},
    alpha_r_b2={1,3,6,6,2,3},
    alpha_r_b3={2.46,2.09,0.88,1.09,3.25,4.62},
    alpha_r_b4={1,1,1,1,2,2},
    alpha_r_nG=7,
    alpha_r_g1={0.017534618,0.33874242,0.22228777,-0.23219062,-0.092206940,-0.47575718,
        -0.017486824},
    alpha_r_g2={1,1,1,2,2,4,1},
    alpha_r_g3={0.76,2.50,2.75,3.05,2.55,8.40,6.75},
    alpha_r_g4={-0.963,-1.977,-1.917,-2.307,-2.546,-3.28,-14.6},
    alpha_r_g5={1.283,0.6936,0.788,0.473,0.8577,0.271,0.948},
    alpha_r_g6={-2.33,-3.47,-3.15,-3.19,-0.92,-18.8,-547.8},
    alpha_r_g7={0.684,0.829,1.419,0.817,1.500,1.426,1.093});

end EoS_Sangi;
