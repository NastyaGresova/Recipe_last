function Test1()  // типовое назначение из глоссария, проверка что рецепт в принципе есть
{  
      var w0=Sys.Process("Automedi"); 
      max_height = w0.VCLObject("AMMain").VCLObject("pResume").VCLObject("pForm").VCLObject("pSPEGRE").Window("TScrollBoxWithControls", "", 1).VScroll.Max;
      height=w0.VCLObject("AMMain").VCLObject("pResume").Height;
      //Runner.CallMethod("Unit_var.find_amb_prescriptions",height, max_height); 

      // w1 - объект "амбулаторные назначения"
      var w1 = Runner.CallMethod("Unit_var.return_w1");
  
      var w_AmbForm = w1.Window("TTabSheet", "Амбулаторные назначения", 1).VCLObject("PatDrugDocAmbForm");
      
      // грид: 
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
      w2.ClickTab("Типовые"); 
   
      // текстовое поле для поиска типового назначения по pr_template_schemes_id
      var  temp_w = Runner.CallMethod("Unit_var.return_w2").VCLObject("tsTemplateSchemes").VCLObject("TemplateSchemesGloss").VCLObject("pGrid").VCLObject("pSearch").Window("TEdit", "", 1);
      var pr_template_schemes_id = Runner.CallMethod("Unit_var.return_pr_template_schemes_id");        
       
      temp_w.Keys(pr_template_schemes_id);
      delay(2000);  
      w2.VCLObject("tsTemplateSchemes").VCLObject("TemplateSchemesGloss").VCLObject("tbSelect").Click();
      delay(3000);
 
      w2.ClickTab("Список");
      
      w_grid.VScroll.Pos=2;
      delay(1000);
      w_grid.VScroll.Pos=3;
      delay(1000); 
      w_grid.VScroll.Pos=2;
      delay(2000); 
    
      // w_recipe - грид с рецептами
      w_recipe = w_AmbForm.VCLObject("RecipePanel").VCLObject("TabControl2");
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = 2;

      delay(600);
      var query = "select top 1 * from PR_DRUGS_RECIPE JOIN patdirec on patdirec.patdirec_id=PR_DRUGS_RECIPE.patdirec_id where patdirec.PATIENTS_ID=" +String(Runner.CallMethod("Unit_var.patients_id"))+ "ORDER BY PR_DRUGS_RECIPE_ID DESC"
      RecSet = Runner.CallMethod("Unit_var.db_connection", query);
    
      //тут должны быть чекпоинты 
      if (RecSet.Fields("PR_DRUGS_RECIPE_TYPE_ID").Value != 1)
      {
          Log.Error("RECIPE_TYPE");
      }
  
      if (w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Max == 0)
      {
           Log.Error("VScroll");
      } 
      
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = 2; 
      w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("tbView").Click();
      delay(1000); 
      
      //w_edit_recipe - окно-редактор рецепта
      w_edit_recipe = Sys.Process("Automedi").VCLObject("fmPRDrugsRecipeEdit")
   
      id_from_db = "0" + String(RecSet.Fields("PR_DRUGS_RECIPE_TYPE_ID").Value - 1)

      aqObject.CheckProperty(w_edit_recipe.VCLObject("pRecord").VCLObject("lkRecipeType").VCLObject("Code").Window("Edit", "", 1), "wText", 0, id_from_db);
  
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