Перем мСписокВозможныхРеквизитов Экспорт;
Перем мРеквизитыКонтрольУникальности Экспорт;
Перем ПрошлыйИзмененныйРодительОбъектаДоступа;

Перем мЭтоНеНовый Экспорт;
// ++ УГМК Игитов М.А.09.01.2012 15:55:49 
Перем мНовый;
// -- УГМК Игитов М.А.09.01.2012 15:55:52 

//+ УГМК_Ичетовкин 16.07.2010 9:40:15 
Перем НадоЗаполнитьНГ;
Перем ТипАвтоШтрихКода;
Перем тПродукцияТНП;
//- УГМК_Ичетовкин 16.07.2010 9:40:18 

// Обработчик события элемента ПриКопировании.
//
Процедура ПриКопировании(ОбъектКопирования)

	Если Не ЭтоГруппа Тогда
		ЕдиницаХраненияОстатков = Неопределено;
		ЕдиницаДляОтчетов       = Неопределено;
		ЕдиницаИзмеренияМест    = Неопределено;
		ОсновноеИзображение     = Неопределено;
		НазначениеИспользования = Неопределено;
	КонецЕсли;
	
КонецПроцедуры // ПриКопировании()

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
КонецПроцедуры // ПередЗаписью()

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
КонецПроцедуры

