// Обработчик события элемента ПриКопировании
//
Процедура ПриКопировании(ОбъектКопирования)

	Если Не ЭтоГруппа Тогда
		ЕдиницаХраненияОстатков = Неопределено;
	КонецЕсли; 

КонецПроцедуры

// Обработчик события ПередЗаписью формы.
//
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
КонецПроцедуры // ПередЗаписью()


Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
КонецПроцедуры

