
#Область ПрограммныйИнтерфейс

Функция ОпределитьНеобходимостьОбновления() Экспорт
	
	СписокОбработчиковОбновления = ПолучитьСписокОбработчиковОбновленияТекущейВерсии();
	
	Возврат НЕ СписокОбработчиковОбновления.Количество() = 0;
	
КонецФункции

Процедура ОбновитьБазуДанных(Отказ, Лог) Экспорт
	
	НоваяВерсияПриложения = Метаданные.Версия;
	
	СписокОбработчиков = ПолучитьСписокОбработчиковОбновленияТекущейВерсии();
	
	Попытка
		
		Для Каждого Обработчик Из СписокОбработчиков Цикл
			
			Если Обработчик = "2.0.3" Тогда
				
				ВыполнитьОбновление2_0_3(Лог);
				
			ИначеЕсли Обработчик = "2.6.1" Тогда
				
				ВыполнитьОбновление2_6_1(Лог);
			КонецЕсли;
			
		КонецЦикла;
		
		Константы.ТекущаяВерсияПриложения.Установить(НоваяВерсияПриложения);
		ОбновитьПовторноИспользуемыеЗначения();
		
	Исключение
		
		Отказ = Истина;
		Лог = ОписаниеОшибки();
		
	КонецПопытки;
	
	ПараметрыСеанса.ОбновлениеБД = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыОбновления

Процедура ВыполнитьОбновление2_0_3(Лог)
	
	// ЗагружатьНастройки
	ВидТранспортаСообщенийОбмена = Константы.ВидТранспортаСообщенийОбмена.Получить();
	
	Если ВидТранспортаСообщенийОбмена = Перечисления.ВидыТранспортаСообщенийОбмена.FILE Тогда
		
		Если ЗначениеЗаполнено(Константы.ИмяФайлаНастроек.Получить()) Тогда
			Константы.ЗагружатьНастройки.Установить(Истина);
		КонецЕсли;
		
	ИначеЕсли ВидТранспортаСообщенийОбмена = Перечисления.ВидыТранспортаСообщенийОбмена.WS Тогда
		Константы.ЗагружатьНастройки.Установить(Истина);
		
		// АдресWS
		ОбщегоНазначенияВызовСервера.СохранитьНастройкуПользователя("ВидАдресаПодключенияWS", 1);
	КонецЕсли;
	
	// ИНН
	// НаименованиеОрганизации
	// СистемаНалогообложения
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Организации.СистемаНалогообложения,
	|	Организации.ИНН,
	|	Организации.Наименование
	|ИЗ
	|	Справочник.УдалитьОрганизации КАК Организации";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Константы.ИНН.Установить(Выборка.ИНН);
		Константы.НаименованиеОрганизации.Установить(Выборка.Наименование);
		Константы.СистемаНалогообложения.Установить(Выборка.СистемаНалогообложения);
	КонецЕсли;
	
	
	// Цены номенклатуры
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	УдалитьЦеныНоменклатуры.Номенклатура КАК Номенклатура,
	|	УдалитьЦеныНоменклатуры.Цена КАК Цена
	|ИЗ
	|	РегистрСведений.УдалитьЦеныНоменклатуры КАК УдалитьЦеныНоменклатуры";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ОбъектНоменклатура = Выборка.Номенклатура.ПолучитьОбъект();
		ОбъектНоменклатура.Цена = Выборка.Цена;
		ОбъектНоменклатура.Записать();
	КонецЦикла;
	
	// Чеки
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Чек.Ссылка
	|ИЗ
	|	Документ.Чек КАК Чек";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ЕстьИзменение = Ложь;
		
		ЧекОбъект = Выборка.Ссылка.ПолучитьОбъект();
		
		Товары = ЧекОбъект.Товары;
		
		Для Каждого Строка Из Товары Цикл
			Если ЗначениеЗаполнено(Строка.УдалитьСуммаСНДС) Тогда
				Строка.Сумма = Строка.УдалитьСуммаСНДС;
				ЕстьИзменение = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если ЕстьИзменение Тогда
			ЧекОбъект.Записать(РежимЗаписиДокумента.Проведение);
		КонецЕсли;
	КонецЦикла;
	
	// ВнесениеИзъятиеНаличных
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВнесениеИзъятиеНаличных.Ссылка
	|ИЗ
	|	Документ.ВнесениеИзъятиеНаличных КАК ВнесениеИзъятиеНаличных";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ВнесениеИзъятиеНаличныхОбъект = Выборка.Ссылка.ПолучитьОбъект();
		ВнесениеИзъятиеНаличныхОбъект.Записать(РежимЗаписиДокумента.Проведение);
	КонецЦикла;
	
КонецПроцедуры

Процедура ВыполнитьОбновление2_6_1(Лог)
	
	Справочники.ВидыАлкогольнойПродукции.ОбновитьСправочникИзКлассификатораВидовАлкогольнойПродукции();
	
	ОбновитьКодВидаАлкогольнойПродукцииВПрайсЛисте();
	
КонецПроцедуры

Процедура ОбновитьКодВидаАлкогольнойПродукцииВПрайсЛисте()
	
	Если НЕ ЗначениеНастроекВызовСервераПовтИсп.ЭтоАвтономныйРежим() Тогда
		
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Номенклатура.Ссылка КАК Номенклатура,
		|	Номенклатура.ВидАлкогольнойПродукции.Код КАК КодВида
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	НЕ Номенклатура.ВидАлкогольнойПродукции = ЗНАЧЕНИЕ(Справочник.ВидыАлкогольнойПродукции.ПустаяСсылка)
		|	И НЕ Номенклатура.КодВидаАлкогольнойПродукции = Номенклатура.ВидАлкогольнойПродукции.Код";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоменклатураОбъект = Выборка.Номенклатура.ПолучитьОбъект();
		НоменклатураОбъект.КодВидаАлкогольнойПродукции = Выборка.КодВида;
		НоменклатураОбъект.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Сравнить две строки версий.
//
// Параметры:
//  СтрокаВерсии1  - Строка - номер версии в формате РР.{П|ПП}.ЗЗ.
//  СтрокаВерсии2  - Строка - второй сравниваемый номер версии.
//
// Возвращаемое значение:
//   Число   - больше 0, если СтрокаВерсии1 > СтрокаВерсии2; 0, если версии равны.
//
Функция СравнитьВерсии(Знач СтрокаВерсии1, Знач СтрокаВерсии2)
	
	//Строка1 = ?(ПустаяСтрока(СтрокаВерсии1), "0.0.0", СтрокаВерсии1);
	//Строка2 = ?(ПустаяСтрока(СтрокаВерсии2), "0.0.0", СтрокаВерсии2);
	//
	//Версия1 = СтрРазделить(Строка1, ".");
	//Если Версия1.Количество() <> 3 Тогда
	//	ВызватьИсключение ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыВСтроку(
	//		НСтр("ru = 'Неправильный формат параметра СтрокаВерсии1: %1'"), СтрокаВерсии1);
	//КонецЕсли;
	//
	//Версия2 = СтрРазделить(Строка2, ".");
	//Если Версия2.Количество() <> 3 Тогда
	//	
	//	ВызватьИсключение ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыВСтроку(
	//		НСтр("ru = 'Неправильный формат параметра СтрокаВерсии2: %1'"), СтрокаВерсии2);
	//КонецЕсли;
	
	Результат = 0;
	
	//Для Разряд = 0 По 2 Цикл
	//	Результат = Число(Версия1[Разряд]) - Число(Версия2[Разряд]);
	//	Если Результат <> 0 Тогда
	//		Возврат Результат;
	//	КонецЕсли;
	//КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция СписокОбработчиковОбновления()
	
	СписокОбработчиков = Новый Массив;
	СписокОбработчиков.Добавить("2.0.3");
	СписокОбработчиков.Добавить("2.6.1");
	
	Возврат СписокОбработчиков;
	
КонецФункции

Функция ПолучитьСписокОбработчиковОбновленияТекущейВерсии()
	
	СписокОбработчиковОбновления = Новый Массив;
	
	ТекущаяВерсия = ЗначениеНастроекВызовСервераПовтИсп.ТекущаяВерсияПриложения();
	СписокОбработчиков = СписокОбработчиковОбновления();
	
	Для Каждого Обработчик Из СписокОбработчиков Цикл
		
		Если СравнитьВерсии(ТекущаяВерсия, Обработчик) < 0 Тогда
			
			СписокОбработчиковОбновления.Добавить(Обработчик);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат СписокОбработчиковОбновления;
	
КонецФункции

#КонецОбласти