///////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПриКопировании(ОбъектКопирования)
	
	//ФизическиеЛицаПереопределяемый.ПриКопировании(ЭтотОбъект, ОбъектКопирования);
	
	Если Не ЭтоГруппа Тогда
		ОсновноеИзображение = Неопределено;
		ИНН = "";
		КодИМНС = "";
		СтраховойНомерПФР = "";
		МестоРождения = ""; МестоРожденияКодПоОКАТО = "";
		СоставСемьи.Очистить();
		Образование.Очистить();
		ТрудоваяДеятельность.Очистить();
		ЗнаниеЯзыков.Очистить();
		Профессии.Очистить();
		Стажи.Очистить();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Отказ = Истина;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ

мДлинаСуток = 86400;