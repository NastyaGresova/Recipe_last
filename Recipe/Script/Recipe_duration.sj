function Test4()  // редактирование рецепта 3 длительность рецепта
{  
      var w0=Sys.Process("Automedi"); 
      max_height = w0.VCLObject("AMMain").VCLObject("pResume").VCLObject("pForm").VCLObject("pSPEGRE").Window("TScrollBoxWithControls", "", 1).VScroll.Max;
      height=w0.VCLObject("AMMain").VCLObject("pResume").Height;
      //Runner.CallMethod("Unit_var.find_amb_prescriptions",height, max_height); 

      // w1 - объект "амбулаторные назначения"
      var w1 = Runner.CallMethod("Unit_var.return_w1");
  
      var w_AmbForm = w1.Window("TTabSheet", "Амбулаторные назначения", 1).VCLObject("PatDrugDocAmbForm"); 
      
      //грид: 
      w_grid = w_AmbForm.VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid");
      w_grid.VScroll.Pos=1;
      delay(1000);
    
      // нужно сперва создать назначение:
      w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("SimplePanel").VCLObject("edMed").Click();
      w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("memComment").Click();  
      w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("SimplePanel").VCLObject("edMed").Click();
      delay(1000); 
      // w2 - глоссарий справа
      var w2 = Runner.CallMethod("Unit_var.return_w2"); 
      w2.VCLObject("tsDrugList").VCLObject("GridDrugsForm").VCLObject("pGrid").VCLObject("pSearch").Window("TEdit", "", 1).Keys(Runner.CallMethod("Unit_var.pr_drugs_id"));
      delay(1000);
      w2.VCLObject("tsDrugList").VCLObject("GridDrugsForm").VCLObject("tbAddDrug").Click();   
      Runner.CallMethod("Unit_var.close_confirmation_window", w0);
      Runner.CallMethod("Unit_var.intake", w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1"), Runner.CallMethod("Unit_var.intake_method_i"));
      delay(1000); 
      w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("btnAddDrugPrescr").Click();
      delay(2000);
    
      // w_recipe - рецепты
      w_recipe = w_AmbForm.VCLObject("RecipePanel").VCLObject("TabControl2");
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = 2;
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("tbEdit").Click();   
    
      // w_edit_recipe - окно-редактор рецепта
      w_edit_recipe = Sys.Process("Automedi").VCLObject("fmPRDrugsRecipeEdit");
      w_edit_recipe.VCLObject("pRecord").VCLObject("DBLookup2").VCLObject("bRun").Click();
      Sys.Process("Automedi").VCLObject("DBDocForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = Runner.CallMethod("Unit_var.return_pr_validity_period_id");
      Sys.Process("Automedi").VCLObject("DBDocForm").VCLObject("BtnOk").Click();
      w_edit_recipe.VCLObject("tbClose").Click();
      delay(1000);   
   
      var query = "select top 1 * from PR_DRUGS_RECIPE JOIN patdirec on patdirec.patdirec_id=PR_DRUGS_RECIPE.patdirec_id where patdirec.PATIENTS_ID=" +String(Runner.CallMethod("Unit_var.patients_id"))+ "ORDER BY PR_DRUGS_RECIPE_ID DESC"
      RecSet = Runner.CallMethod("Unit_var.db_connection", query);
   
      if (RecSet.Fields("PR_VALIDITY_PERIOD_ID").Value != Runner.CallMethod("Unit_var.return_pr_validity_period_id"))
      {
          Log.Error("duration_db");
      }
  
      var version = Runner.CallMethod("Unit_var.return_version");
      
      if (version == 5)
      {
            var durantion_list = ["15 дней", "30 дней", "60 дней", "90 дней", "до 1 года"]
      }
      else
      {
            var durantion_list = ["15", "30", "60", "90", "365"]
      }

      current_duration =  durantion_list[Runner.CallMethod("Unit_var.return_pr_validity_period_id")-1]
 
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = 2; 
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("tbView").Click();
      delay(2000); 
   
      var duration_from_recipe = Sys.Process("Automedi").VCLObject("fmPRDrugsRecipeEdit").VCLObject("pRecord").VCLObject("DBLookup2").VCLObject("Code").Window("Edit", "", 1).wText;
      
      if (duration_from_recipe != current_duration)
      {
          Log.Error("duration_window");
      }    
      w0.VCLObject("fmPRDrugsRecipeEdit").Close();
      
      // теперь нужно удалить назначение:
      w_grid.VScroll.Pos=2;
      delay(500);
      w_grid.VScroll.Pos=3;
      delay(500); 
      w_grid.VScroll.Pos=2;
      delay(500);
  
      w_AmbForm.VCLObject("pTop").VCLObject("pTool").VCLObject("ToolBar").VCLObject("TToolButton_13").Click();
      // подтверждение перед удалением:
      Sys.Process("Automedi").Window("TMessageForm", "Подтверждение", 1).VCLObject("Yes").Click();
      delay(2500);
      w_grid.VScroll.Pos=1;
}