
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ВидОперации = Параметры.ВидОперации;
	ЭтаФорма.Заголовок = УГМК_МобильныйСервер.ПредставлениеВидОперации(ВидОперации);
КонецПроцедуры


&НаКлиенте
Процедура СоздатьНовый(Команда)
	ПараметрыФормы = Новый Структура;
    ПараметрыФормы.Вставить("ВидОперации", ВидОперации);
    ПараметрыФормы.Вставить("Объект", Неопределено);
	ОткрытьФорму("Документ.УГМК_ДокументФакт.Форма.ФормаДокумента",ПараметрыФормы, ЭтаФорма);	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	//ПараметрыФормы = Новый Структура;
	//ПараметрыФормы.Вставить("ВидОперации", ВидОперации);
	//ПараметрыФормы.Вставить("Объект", Элементы.Список.ТекущиеДанные.Ссылка);
	//ОткрытьФорму("Документ.УГМК_ДокументФакт.Форма.ФормаДокумента",ПараметрыФормы,Этаформа);	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	ПараметрыФормы = Новый Структура;
    ПараметрыФормы.Вставить("ВидОперации", ВидОперации);
	Если Элементы.Список.ТекущиеДанные <> Неопределено Тогда
    	ПараметрыФормы.Вставить("Ключ", Элементы.Список.ТекущаяСтрока);
		ОткрытьФорму("Документ.УГМК_ДокументФакт.Форма.ФормаДокумента",ПараметрыФормы,Этаформа);	
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ОбновитьСписокДокументов" Тогда
		Элементы.Список.Обновить();
		//ЭтаФорма.ОбновитьОтображениеДанных();
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаАктивизации(АктивныйОбъект, Источник)
	
КонецПроцедуры



