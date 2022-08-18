# Инструкция для проекта "Recipe"
В проекте Recipe лежат тесты для проверки функционала, связанного с рецептами. Вот описание каждого из тестов:

* Recipe_toolbar *- создание рецепта по кнопке в тулбаре*
* Recipe_MNN *- создание рецепта со сложным МНН*
* Personal_Scheme_checkbox *- галочка "По спец. назначению"*
* Statim_checkbox *- галочка "Statim"*
* Recipe_duration *- изменение срока действия рецепта*
* Series *- изменение серии рецепта*
* Number *- изменение номера рецепта*
* Recipe_drugs_amount *- заполнение поля "количество отпускаемого препарата"*
* Recipe_type *- изменение типа рецепта*
* Typical_gloss *- проверка, что рецепт создается для типового назначения, добавленного из глоссария*
* Typical_toolbar *- проверка, что рецепт создается для типового назначения, добавленного по кнопке в тулбаре*
* Simple_toolbar *- проверка, что рецепт создается для простого назначения, добавленного по кнопке в тулбаре*
* Complex_Gloss *- проверка, что рецепт создается для составного назначения, добавленного из глоссария*

## Чтобы запустить проект на своем компьютере, нужно выполнить 3 следующие инструкции ##

> ### 1. Нужно создать подключение к БД
>
>> ##### **1.1.** Windows -> Панель управления -> Администрирование -> Источники данных (ODBC):
>> ![Источники данных (ODBC)](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db_1.PNG)
>>
>> ##### 1.2. В окне "Создание нового источника данных" выбрать "ODBC Driver 17 for SQL Server":
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db2.PNG)
>>
>> ##### 1.3. В окне "Создание источника данных для SQL Server" заполнить имя для источника данных и выбрать нужный сервер:
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db3.PNG)
>>
>> ##### 1.4. Далее выбрать пункт "проверка подлинности учетной записи SQL Server" и ввести имя пользователя и пароль:
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db4.PNG)
>>
>> ##### 1.5. Проставить галочку "Использовать по умолчанию базу данных" и выбрать базу данных, к которой нужно подключаться:
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db5.PNG)
>>
>> ##### 1.6. На следующем этапе ничего не меняем, нажимаем на кнопку "Готово":
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db6.PNG)
>>
>> ##### 1.7. В окне "Установка ODBC для Microsoft SQL Server" нажать на кнопку "Проверить источник данных...":
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db7.PNG)
>>
>> ##### 1.8. Если все ок, то получаем такой результат:
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/connection_db8.PNG)
>
> ### 2. Теперь нужно выполнить некоторые настройки в Медиалоге
>
>> #### 2.1. Настроить модели поиска в соответствии с тем, как указано на скриншотах
>> 
>>> ##### 2.1.1. В глоссарии для объекта "Амбулаторные назначения", вкладка "Список"
>>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/base_tests_gloss_simple.PNG)
>>>
>>> ##### 2.1.2. В глоссарии для объекта "Амбулаторные назначения", вкладка "Типовые"
>>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/base_tests_gloss_typical.PNG)
>>> 
>>> ##### 2.1.3. В окне для поиска медикаментов
>>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/base_tests_toolbar_drug.PNG)
>>> 
>>> ##### 2.1.4. В окне для поиска типовых назначений
>>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/base_tests_toolbar_typical.PNG)
>>>
>>> ##### 2.1.5. В проекте "Recipe" способ введения в назначение добавляется двойным кликом из глоссария, поэтому нужно учесть, что глоссарий со способами введения не должен быть пустым
>>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/base_tests_gloss_intake_methods.PNG)
>>
>> ##### 2.2. В настройках компоненты "Услуги" должна стоять галочка "Рецепты"
>> ![Имя изображения](https://github.com/NastyaGresova/HelloWorld/blob/main/settings_services.png)
>>
>> ##### 2.3. Системные параметры PR_TEMPLATES_SIMPLE_DEFAULT и PR_TEMPLATES_MULTIPLE_DEFAULT должны быть заполнены. Схемы в системных параметрах могут быть любыми.
>
> ### 3. Нужно настроить переменные в файле Unit_var.sj

Сейчас в файле Unit_var.sj настроены переменные для следующих тестовых баз:
* \\SQL-SERVER\CLIENTS_BASE\TESTIROVANYE\ALL\TESTERS_800_DEV_BTK
* \\Sql-server2019\clients_base\TESTIROVANYE\ALL\Testers_810_DEV_Collection_7DF
* \\SQL-SERVER2019\CLIENTS_BASE\TESTIROVANYE\ALL\TESTERS_810_4_COLLECTION_7DF

Для того, чтобы запустить проект, нужно в файле Unit_var.sj оставить переменные для базы, на которой будут проводиться тесты, а остальные переменные закомментировать.
Можно не изменять переменные в файле, тогда тесты будут проходить по одним и тем же значениям (под значениями имеются ввиду медикаменты, схема приема, способ введения и т.д.). Но для того, чтобы тесты прогонялись по разным значениям, переменные нужно менять. 
Файл Unit_var.sj разделен на три блока:
* переменные для работы на базе \\SQL-SERVER\CLIENTS_BASE\TESTIROVANYE\ALL\TESTERS_800_DEV_BTK
* переменные для работы на базе \\Sql-server2019\clients_base\TESTIROVANYE\ALL\Testers_810_DEV_Collection_7DF
* переменные для работы на базе \\SQL-SERVER2019\CLIENTS_BASE\TESTIROVANYE\ALL\TESTERS_810_4_COLLECTION_7DF


Чтобы изменить переменные, выберем один из блоков. Например, возьмем переменные для работы на базе \\Sql-server2019\clients_base\TESTIROVANYE\ALL\Testers_810_DEV_Collection_7DF
В первой части этого блока находится список переменных. Далее идут различные функции. Функции менять не нужно.

var w0_var = Sys.Process("Automedi"); *- переменную w0_var менять не нужно, это сам процесс Automedi, он везде одинаковый*

var version = 5;  *- номер версии, для DEV-версии version = 5, а для пользовательской версии version = 4* 

var patients_id_var = 3486143; *- id пациента, на котором проводятся тесты*

var pr_drugs_id_var = 2175;   *- id основного медикамента, этот медикамент будет использоваться в большей части тестов*

var pr_drugs_id_list = [17, 56, 2];   *- id медикаментов, на основе которых делается составное назначение*

var intake_method_i_var = 2; *- просто порядковый номер способа введения из глоссария*  

var pr_drugs_id_composite_mnn = 103; *- id медикамента со сложным МНН* 

var pr_drugs_recipe_type_id_var = 5; *- id типа рецепта*  

var pr_validity_period_id_var = 5; *- id длительности рецепта*

var series_recipe = 567;  *- серия рецепта*

var number_recipe = 76; *- номер рецепта*

var drugs_amount_recipe = 67; *- количество медикамента в рецепте*

var scheme_name_window_DirServEditor = "test1" *- название схемы приема, которая выбирается в окне-редакторе назначения*

var pr_template_schemes_id = 132;  *-  id типового назначения*
