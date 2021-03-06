Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СерииНоменклатуры.УГМК_Упаковка,
		|	СерииНоменклатуры.Ссылка,
		|	СерииНоменклатуры.Владелец
		|ИЗ
		|	Справочник.СерииНоменклатуры КАК СерииНоменклатуры
		|ГДЕ
		|	СерииНоменклатуры.УГМК_Упаковка = &Док";

	Запрос.УстановитьПараметр("Док", ЭтотОбъект.Ссылка);
	Результат = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = Результат.Выбрать();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		 ТекСтрока = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
		 ТекСтрока.УГМК_Упаковка = Документы.УГМК_Упаковка.ПустаяСсылка();
		 ТекСтрока.Записать();
	КонецЦикла;
	 
    Если ВидОперации = Перечисления.УГМК_ВидыОперацийУпаковка.Перевозка Тогда 
		Возврат;
	КонецЕсли; 
	
	Для Каждого ТекущаяСтрока Из ЭтотОбъект.Товары Цикл 
		 ТекСтрока = ТекущаяСтрока.СерияНоменклатуры.ПолучитьОбъект();
		 ТекСтрока.УГМК_Упаковка = ЭтотОбъект.Ссылка;
		 ТекСтрока.Записать();
	 КонецЦикла; 
	 
КонецПроцедуры

// Возвращает доступные варианты печати документа
//
// Возвращаемое значение:
//  Структура, каждая строка которой соответствует одному из вариантов печати
//  
Функция ПолучитьСтруктуруПечатныхФорм() Экспорт
	
	СтруктураМакетов = Новый Структура;
	
	Возврат СтруктураМакетов;

КонецФункции // ПолучитьСтруктуруПечатныхФорм()

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СерииНоменклатуры.УГМК_Упаковка,
		|	СерииНоменклатуры.Ссылка,
		|	СерииНоменклатуры.Владелец
		|ИЗ
		|	Справочник.СерииНоменклатуры КАК СерииНоменклатуры
		|ГДЕ
		|	СерииНоменклатуры.УГМК_Упаковка = &Док";

	Запрос.УстановитьПараметр("Док", ЭтотОбъект.Ссылка);
	Результат = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = Результат.Выбрать();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		 ТекСтрока = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
		 ТекСтрока.УГМК_Упаковка = Документы.УГМК_Упаковка.ПустаяСсылка();
		 ТекСтрока.Записать();
	 КонецЦикла;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка = Истина Тогда
		Возврат;
	КонецЕсли; 
	
	Если ВидОперации = Перечисления.УГМК_ВидыОперацийУпаковка.Перевозка Тогда
		Контрагент = Справочники.Контрагенты.ПустаяСсылка();
		ЗаказПокупателя	= Документы.ЗаказПокупателя.ПустаяСсылка();
		Тара			= Справочники.Номенклатура.ПустаяСсылка();
		ОтгрузочнаяПартия	= "";
	КонецЕсли; 
	
КонецПроцедуры

