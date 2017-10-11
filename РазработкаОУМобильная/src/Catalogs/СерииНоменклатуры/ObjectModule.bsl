////////////////////////////////////////////////////////////////////////////////
// ЭКСПОРТИРУЕМЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// Функция устанавливает новое наименование серии по значениям реквизитов.
//
// Параметры:
//  Нет.
//
// Возвращаемое значение:
//  Строка - сформированное наименование.
//
Функция СформироватьНаименование() Экспорт

	Строка = "";

	Возврат Строка;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПриКопировании(ОбъектКопирования)
	
	Если Не ЭтоГруппа Тогда
		
		ОсновноеИзображение = Неопределено;
		
	КонецЕсли;
	
КонецПроцедуры

// Процедура вызывается перед записью элемента справочника.
//
Процедура ПередЗаписью(Отказ)

	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	

КонецПроцедуры // ПередЗаписью()

