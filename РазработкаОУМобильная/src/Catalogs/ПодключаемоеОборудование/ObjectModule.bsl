#Область ОбработчикиСобытий

// Процедура производит инициализацию параметров устройства.
//
Процедура ПередЗаписью(Отказ)
	
	Если ЭтоНовый() Тогда
		Параметры = Новый ХранилищеЗначения(Новый Структура());
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписью()

// Процедура производит очистку реквизитов, которые не должны копироваться.
// Следующие реквизиты очищаются при копировании:
// "Параметры"      - параметры устройства сбрасываются в Неопределено;
//
Процедура ПриКопировании(ОбъектКопирования)
	
	Параметры = Неопределено;
	
КонецПроцедуры

#КонецОбласти
