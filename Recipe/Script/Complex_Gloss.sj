function Test2()     //создание составного назначения 
{
          var w0=Sys.Process("Automedi");    
          var pr_drugs_id_list = Runner.CallMethod("Unit_var.return_pr_drugs_id_list");  //id медикаментов, на основе которых делается составное назначение
  
          //w1 - объект "амбулаторные назначения"
          var w1 = Runner.CallMethod("Unit_var.return_w1");
          
          var w_AmbForm = w1.Window("TTabSheet", "Амбулаторные назначения", 1).VCLObject("PatDrugDocAmbForm");
          
          w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").ClickTab("Простые"); 
          Runner.CallMethod("Unit_var.intake", w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1"), Runner.CallMethod("Unit_var.intake_method_i"));
         
          delay(1000);     
                        
          w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").ClickTab("Составные");  
          
          // грид: 
          w_grid = w_AmbForm.VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid");
          w_grid.VScroll.Pos=1;
  
          for (var i = 0; i < pr_drugs_id_list.length; i++)
          { 
              var w2 = Runner.CallMethod("Unit_var.return_w2");
              var w_Search = w2.VCLObject("tsDrugList").VCLObject("GridDrugsForm").VCLObject("pGrid").VCLObject("pSearch");
              w_Search.Window("TEdit", "", 1).Keys(pr_drugs_id_list[i]);
              //поле очищать надо после айдишника
              delay(1000) ;
              w2.VCLObject("tsDrugList").VCLObject("GridDrugsForm").VCLObject("tbAddDrug").Click();
              Runner.CallMethod("Unit_var.close_confirmation_window", w0); 
              w_Search.Window("TEdit", "", 1).ClickR();
              w_Search.Window("TEdit", "", 1).PopupMenu.Click("Выделить все");
              w_Search.Window("TEdit", "", 1).ClickR(); 
              w_Search.Window("TEdit", "", 1).PopupMenu.Click("Удалить");
          } 
   
         //ДОБАВЛЮ КОММЕНТАРИЙ, ВРЕМЕННО
         //w1.Window("TTabSheet", "Амбулаторные назначения", 1).VCLObject("PatDrugDocAmbForm").VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("memComment").Keys("123339e9qewjdsuichiuwadjoihfvioJSOWIEDHFIUOIPWI");
         //var version = 
         
         
         //опять обход ошибки: ее нужно исправить
         if (Runner.CallMethod("Unit_var.return_version") == 4)
         {
              var w2 = Runner.CallMethod("Unit_var.return_w2");
              var w_temp_Grid = w2.VCLObject("tsDrugList").VCLObject("GridDrugsForm").VCLObject("pGrid");
              w_temp_Grid.VCLObject("pSearch").Window("TEdit", "", 1).Keys("11");
              //поле очищать надо после айдишника
              delay(1000) ;
              
              w_temp_Grid.VCLObject("GridPanel").VCLObject("Grid").ClickR();
              w_temp_Grid.VCLObject("GridPanel").VCLObject("Grid").PopupMenu.Click(Runner.CallMethod("Unit_var.return_scheme_name"));

              Runner.CallMethod("Unit_var.close_confirmation_window", w0); 

         }
         
         delay(2500);  
         w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").VCLObject("PanelNaznach").VCLObject("btnAddDrugPrescr").Click();
         w_AmbForm.VCLObject("PanelTop").VCLObject("TabControl1").ClickTab("Простые"); 
   
         delay(1000);
         w_grid.VScroll.Pos=2;
         delay(500);
         w_grid.VScroll.Pos=3;
         delay(500); 
         w_grid.VScroll.Pos=2;
         delay(1000); 
        
         // w_recipe - грид с рецептами
         w_recipe = w_AmbForm.VCLObject("RecipePanel").VCLObject("TabControl2");
         w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = 2;

         delay(600);
        
         var query = "select top " + String(pr_drugs_id_list.length+1)  + "  * from PR_DRUGS_RECIPE JOIN patdirec on patdirec.patdirec_id=PR_DRUGS_RECIPE.patdirec_id where patdirec.PATIENTS_ID=" +String(Runner.CallMethod("Unit_var.patients_id"))+ "ORDER BY PR_DRUGS_RECIPE_ID DESC"
         RecSet = Runner.CallMethod("Unit_var.db_connection", query);
    
         var i=2;          
         RecSet.MoveFirst();
         while (! RecSet.EOF )
         {
              if (RecSet.Fields("PR_DRUGS_RECIPE_TYPE_ID").Value != 1)
              {
                  Log.Error("RECIPE_TYPE");
              }             
              w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Pos = i;
              w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("tbView").Click();
            
              delay(1000); 
      
              //w_edit_recipe - окно-редактор рецепта
              w_edit_recipe = Sys.Process("Automedi").VCLObject("fmPRDrugsRecipeEdit");
      
              id_from_db = "0" + String(RecSet.Fields("PR_DRUGS_RECIPE_TYPE_ID").Value - 1);
              aqObject.CheckProperty(w_edit_recipe.VCLObject("pRecord").VCLObject("lkRecipeType").VCLObject("Code").Window("Edit", "", 1), "wText", 0, id_from_db);
            
              if (i+1 <= w_recipe.VCLObject("PanelRecipe").VCLObject("PatDocAmbRecipeForm").VCLObject("pGrid").VCLObject("GridPanel").VCLObject("Grid").VScroll.Max)
              {
                 i = i+1;
              }
              else
              {
                 i = i;
              }           
              RecSet.MoveNext();
         }   

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