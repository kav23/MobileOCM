
#Область ПрограммныйИнтерфейс

Процедура СоздатьРезервнуюКопию() Экспорт

	Результат = ПолучитьСтруктуруРезультата();
	
	РезервноеКопированиеВызовСервера.СоздатьРезервнуюКопию(Результат);
	
	Если Не Результат.ЕстьОшибки Тогда 
		
		ТекстСообщения = НСтр("ru = 'Резервное копирование информационной базы выполнено успешно!'");
		ПоказатьПредупреждение(,ТекстСообщения);
	Иначе
		ПоказатьПредупреждение(,Результат.Описание);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВосстановитьИзРезервнойКопии() Экспорт
	
	Результат = ПолучитьСтруктуруРезультата();
	
	РезервноеКопированиеВызовСервера.ВосстановитьИзРезервнойКопии(Результат);
	
	Если НЕ Результат.ЕстьОшибки Тогда
		ОткрытьФорму("Обработка.Сервис.Форма.ЗагрузкаИнформационнойБазы", Результат);
	Иначе
		ПоказатьПредупреждение(,Результат.Описание);
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗагрузитьБазуИзXML(ПараметрыРезервнойКопии, ОписаниеПослеВосстановления) Экспорт
	
	Результат = ПолучитьСтруктуруРезультата();
	
	РезервноеКопированиеВызовСервера.ЗагрузитьБазуИзXML(ПараметрыРезервнойКопии, Результат);
	
	Если НЕ Результат.ЕстьОшибки Тогда 
		
		ТекстСообщения = НСтр("ru = 'Информационная база успешно восстановлена!'");
		ПоказатьПредупреждение(ОписаниеПослеВосстановления, ТекстСообщения);
		Оповестить("ИзмененыЗначенияНастроек");
		ОбновитьИнтерфейс();
	ИначеЕсли Результат.НеВсеДанныеЗагружены Тогда 
		
		ТекстСообщения = НСтр("ru='Не все данные были загружены.'");
		ПоказатьПредупреждение(ОписаниеПослеВосстановления, ТекстСообщения);
		Оповестить("ИзмененыЗначенияНастроек");
		ОбновитьИнтерфейс();
	Иначе
		ПоказатьПредупреждение(, Результат.Описание);
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьПутьРезервногоКопированияПриПервомЗапуске() Экспорт
	
	КаталогДокументов = КаталогДокументов();
	РезервноеКопированиеВызовСервера.УстановитьПутьРезервногоКопированияПриПервомЗапуске(КаталогДокументов);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьСтруктуруРезультата()
	
	Результат = Новый Структура;
	
	Результат.Вставить("ЕстьОшибки", Ложь);
	Результат.Вставить("Описание", "");
	
	Результат.Вставить("ВыгруженныеБазыЛокальные", Неопределено);
	Результат.Вставить("ВыгруженныеБазы", Неопределено);  // ВыгруженныеБазыЯндекс
	
	Результат.Вставить("СтрокаПодключения", "");
	
	Результат.Вставить("НеВсеДанныеЗагружены", Ложь);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
