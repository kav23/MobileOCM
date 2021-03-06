
#Область ПрограммныйИнтерфейс

Процедура СоздатьРезервнуюКопию(Результат) Экспорт
	
	РезервныеКопииНаЯндексДиске = ЗначениеНастроекПовтИсп.ПолучитьЗначениеКонстанты("РезервныеКопииНаЯндексДиске");
	РезервныеКопииНаУстройстве = ЗначениеНастроекПовтИсп.ПолучитьЗначениеКонстанты("РезервныеКопииНаУстройстве");
	
	// Проверка
	ПроверкаСоединенияЯндексУспешна = Ложь;
	Если РезервныеКопииНаЯндексДиске Тогда
		
		СтруктураПодключенияЯндекс = Новый Структура;
		УстановитьСтрокуПодключенияЯндекс(СтруктураПодключенияЯндекс);
		
		ФайлИнформацииОВыгрузкахЛокальный = ПолучитьИмяВременногоФайла(".xml");
		Попытка
			КопироватьФайл(СтруктураПодключенияЯндекс.РезервноеКопированиеФайлИнформацииОВыгрузках, ФайлИнформацииОВыгрузкахЛокальный);
		Исключение
			ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
			
			Если ТипОшибки <> Перечисления.РезервноеКопированиеПодключениеКСерверу.ФайлНеНайден Тогда 
				Результат.ЕстьОшибки = Истина;
				Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
				Возврат;
			КонецЕсли;
			
			ЗаписьXML = Новый ЗаписьXML;
			ЗаписьXML.ОткрытьФайл(ФайлИнформацииОВыгрузкахЛокальный);
			ЗаписьXML.ЗаписатьОбъявлениеXML();
			ЗаписьXML.ЗаписатьНачалоЭлемента("applications");
			ЗаписьXML.ЗаписатьКонецЭлемента();
			ЗаписьXML.Закрыть();
		КонецПопытки;
		
		ПроверкаСоединенияЯндексУспешна = Истина;
		
	КонецЕсли;
	
	
	ПроверкаСоединенияЛокальногоКаталогаУспешна = Ложь;
	Если РезервныеКопииНаУстройстве Тогда
		
		КаталогРезервногоКопирования = Константы.КаталогРезервногоКопирования.Получить();
		Если НЕ ЗначениеЗаполнено(КаталогРезервногоКопирования) Тогда
			
			ТекстСообщения = НСтр("ru = 'Не указан локальный каталог в настройках резервного копирования'");
			ВызватьИсключение(ТекстСообщения);
		Иначе
			ПроверкаСоединенияЛокальногоКаталогаУспешна = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	// Копирование
	
	Если РезервныеКопииНаУстройстве И ПроверкаСоединенияЛокальногоКаталогаУспешна Тогда
		
		ВыгрузитьБазуНаУстройство(КаталогРезервногоКопирования, Результат);
		
	КонецЕсли;
	
	Если РезервныеКопииНаЯндексДиске И ПроверкаСоединенияЯндексУспешна Тогда
		ВыгрузитьБазуНаЯндексДиск(ФайлИнформацииОВыгрузкахЛокальный, СтруктураПодключенияЯндекс, Результат);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВосстановитьИзРезервнойКопии(Результат) Экспорт
	
	РезервныеКопииНаЯндексДиске = Константы.РезервныеКопииНаЯндексДиске.Получить();
	РезервныеКопииНаУстройстве = Константы.РезервныеКопииНаУстройстве.Получить();
	ВыгруженныеБазы = Новый Массив;
	
	Если РезервныеКопииНаУстройстве Тогда
		
		КаталогРезервногоКопирования = ЗначениеНастроекПовтИсп.ПолучитьЗначениеКонстанты("КаталогРезервногоКопирования");
		
		Каталог = Новый Файл(КаталогРезервногоКопирования);
		Если НЕ Каталог.Существует() Тогда
			Результат.ЕстьОшибки = Истина;
			Результат.Описание = НСтр("ru = 'Каталог резервного копирования не существует.
			|(Настройки - Резервное копирование)'");
			Возврат;
		КонецЕсли;
		
		Маска = НаименованиеПриложения() + "*.xml";
		
		Файлы = НайтиФайлы(КаталогРезервногоКопирования, Маска, Ложь);
		
		
		Для Каждого Файл Из Файлы Цикл
			
			РеквизитФайла = РазобратьИмяФайлаРезервнойКопии(Файл.Имя);
			
			ВыгруженнаяБаза = Новый Структура;
			
			Представление = НСтр("ru = 'Локальная копия от %ДатаВыгрузки%'");
			Представление = СтрЗаменить(Представление, "%ДатаВыгрузки%", Формат(РеквизитФайла.ДатаВыгрузки, "ДФ='dd.MM.yyyy HH:mm:ss'"));
			
			ВыгруженнаяБаза.Вставить("ИмяФайла",         Файл.Имя);
			ВыгруженнаяБаза.Вставить("Представление",    Представление);
			ВыгруженнаяБаза.Вставить("ВерсияПриложения", РеквизитФайла.Версия);
			ВыгруженнаяБаза.Вставить("ДатаВыгрузки",     РеквизитФайла.ДатаВыгрузки);
			ВыгруженнаяБаза.Вставить("МестоХранения",    "ЛокальныйКаталог");
			ВыгруженнаяБаза.Вставить("ПолноеИмя",        Файл.ПолноеИмя);
			
			
			ВыгруженныеБазы.Добавить(ВыгруженнаяБаза);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если РезервныеКопииНаЯндексДиске Тогда
		
		СтруктураПодключенияЯндекс = Новый Структура;
		УстановитьСтрокуПодключенияЯндекс(СтруктураПодключенияЯндекс);
		
		ФайлИнформацииОВыгрузкахЛокальный = ПолучитьИмяВременногоФайла(".xml");
		
		Попытка
			КопироватьФайл(СтруктураПодключенияЯндекс.РезервноеКопированиеФайлИнформацииОВыгрузках, ФайлИнформацииОВыгрузкахЛокальный);
		Исключение
			Результат.ЕстьОшибки = Истина;
			ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
			Если ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.ФайлНеНайден Тогда 
				Сообщение = НСтр("ru='Резервные копии отсутствуют или указана несуществующая папка.'");
				Результат.Описание = Сообщение;
			Иначе
				Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
			КонецЕсли;
			Возврат;
		КонецПопытки;
		
		ДобавитьФайлВТаблицуВыгруженныхБаз(ФайлИнформацииОВыгрузкахЛокальный, ВыгруженныеБазы);
		
		Результат.СтрокаПодключения = СтруктураПодключенияЯндекс.РезервноеКопированиеСтрокаПодключения;
		
	КонецЕсли;
	
	Результат.ВыгруженныеБазы = ВыгруженныеБазы;
	
КонецПроцедуры

Процедура ЗагрузитьБазуИзXML(ПараметрыРезервнойКопии, Результат) Экспорт
	
	МестоХранения    = ПараметрыРезервнойКопии.МестоХранения;
	ПолноеИмя        = ПараметрыРезервнойКопии.ПолноеИмя;
	ВерсияПриложения = ПараметрыРезервнойКопии.ВерсияПриложения;
	ИмяВыгрузки      = ПараметрыРезервнойКопии.ВыбраннаяБаза;
	
	Если МестоХранения = "ЛокальныйКаталог" Тогда
		
		ОбщегоНазначения.ОчиститьБД(Истина);
		ОбновленныйФайлВыгрузки = УстановитьСоответствиеСМетаданными(ВерсияПриложения, ПараметрыРезервнойКопии.ПолноеИмя);
		
		ВосстановитьИзФайла(ПараметрыРезервнойКопии.ПолноеИмя, Результат);
		
	ИначеЕсли МестоХранения = "ЯндексДиск" Тогда
		СтруктураПодключенияЯндекс = Новый Структура;
		УстановитьСтрокуПодключенияЯндекс(СтруктураПодключенияЯндекс);
		
		ФайлВыгрузкиСервер = СтруктураПодключенияЯндекс.РезервноеКопированиеСтрокаПодключения + ИмяВыгрузки + ".xml";
		
		ФайлВыгрузкиЛокальный = ПолучитьИмяВременногоФайла(".xml");
		
		Попытка
			КопироватьФайл(ФайлВыгрузкиСервер, ФайлВыгрузкиЛокальный);
		Исключение
			ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
			Результат.ЕстьОшибки = Истина;
			Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
			Возврат;
		КонецПопытки;
		
		ОбщегоНазначения.ОчиститьБД(Истина);
		ОбновленныйФайлВыгрузки = УстановитьСоответствиеСМетаданными(ВерсияПриложения, ФайлВыгрузкиЛокальный);
		
		ВосстановитьИзФайла(ОбновленныйФайлВыгрузки, Результат);
		
	КонецЕсли;
	
	ОбщегоНазначенияВызовСервера.ОбновитьПриложение();
	
	ОбновитьПовторноИспользуемыеЗначения();
КонецПроцедуры

Процедура УстановитьПутьРезервногоКопированияПриПервомЗапуске(Каталог) Экспорт
	
	Константы.КаталогРезервногоКопирования.Установить(Каталог);
	Константы.РезервныеКопииНаУстройстве.Установить(Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВосстановитьИзФайла(ОбновленныйФайлВыгрузки, Результат)
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ОбновленныйФайлВыгрузки);
	
	ЧтениеXML.Прочитать();
	ЧтениеXML.Прочитать();
	
	Пока ЧтениеXML.ТипУзла <> ТипУзлаXML.КонецЭлемента Цикл
		Попытка
			Элемент = ЧтениеXML.Имя;
			ЭлементСтрокой = Строка(Элемент);
			
			Если НЕ Найти(ЭлементСтрокой, "Парол") = 0 Тогда
				ПрочитатьXML(ЧтениеXML);
				Продолжить;
			КонецЕсли;
			
			Объект = ПрочитатьXML(ЧтениеXML);
			Объект.ОбменДанными.Загрузка = Истина;
			Объект.Записать();
		Исключение
			Инфо = ИнформацияОбОшибке();
			Пока ЧтениеXML.Имя <> Элемент Цикл 
				ЧтениеXML.Прочитать();
			КонецЦикла;
			ЧтениеXML.Прочитать();
			
			Результат.ЕстьОшибки = Истина;
			Результат.НеВсеДанныеЗагружены = Истина;
		КонецПопытки;
	КонецЦикла;
	ЧтениеXML.Закрыть();
	
КонецПроцедуры

Процедура ВыгрузитьБазуНаЯндексДиск(ФайлИнформацииОВыгрузкахЛокальный, СтруктураПодключенияЯндекс, Результат)
	
	ИмяВыгружаемойБазы = ИмяВыгружаемойБазы();
	
	КоличествоСовпаденийИмен = 0;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ФайлИнформацииОВыгрузкахЛокальный);
	
	ПостроительDOM = Новый ПостроительDOM;
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	ЧтениеXML.Закрыть();
	
	СтрокаXPath = "/applications/application[@name='" + НаименованиеПриложения() + "' and @version='" + Метаданные.Версия + "']/InformationBase";
	
	ВыражениеXPath = ДокументDOM.СоздатьВыражениеXPath(СтрокаXPath, Новый РазыменовательПространствИменDOM(ДокументDOM));
	РезультатXPath = ВыражениеXPath.Вычислить(ДокументDOM);
	
	НетЭлементов = Истина;
	ИнформационнаяБаза = РезультатXPath.ПолучитьСледующий();
	Пока ИнформационнаяБаза <> Неопределено Цикл 
		НетЭлементов = Ложь;
		
		Если Найти(ИнформационнаяБаза.Атрибуты.ПолучитьИменованныйЭлемент("name").Значение, ИмяВыгружаемойБазы) <> 0 Тогда 
			КоличествоСовпаденийИмен = КоличествоСовпаденийИмен + 1;
		КонецЕсли;
		ИнформационнаяБаза = РезультатXPath.ПолучитьСледующий();
	КонецЦикла;
	
	Если КоличествоСовпаденийИмен <> 0 Тогда 
		ИмяВыгружаемойБазы = ИмяВыгружаемойБазы + " (" + КоличествоСовпаденийИмен + ")";
	КонецЕсли;
	
	НовыйФайлИнформацииОВыгрузках = ПолучитьИмяВременногоФайла(".xml");
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(НовыйФайлИнформацииОВыгрузках);
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ФайлИнформацииОВыгрузкахЛокальный);
	
	Пока ЧтениеXML.Прочитать() Цикл 
		
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда 
			ЗаписьXML.ЗаписатьНачалоЭлемента(ЧтениеXML.Имя);
			Пока ЧтениеXML.ПрочитатьАтрибут() Цикл
				ЗаписьXML.ЗаписатьАтрибут(ЧтениеXML.Имя, ЧтениеXML.Значение);
			КонецЦикла;
		КонецЕсли;
		
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.КонецЭлемента Тогда 
			
			Элемент = ЧтениеXML.Имя;
			
			Если Элемент = "application" 
				И ЧтениеXML.ПолучитьАтрибут("name") = НаименованиеПриложения()
				И ЧтениеXML.ПолучитьАтрибут("version") = Метаданные.Версия Тогда
				
				ЗаписьXML.ЗаписатьНачалоЭлемента("InformationBase");
				ЗаписьXML.ЗаписатьАтрибут("name", ИмяВыгружаемойБазы);
				ЗаписьXML.ЗаписатьКонецЭлемента();
			КонецЕсли;
			
			Если Элемент = "applications" И НетЭлементов Тогда 
				ЗаписьXML.ЗаписатьНачалоЭлемента("application");
				ЗаписьXML.ЗаписатьАтрибут("name", НаименованиеПриложения());
				ЗаписьXML.ЗаписатьАтрибут("version", Метаданные.Версия);
				ЗаписьXML.ЗаписатьНачалоЭлемента("InformationBase");
				ЗаписьXML.ЗаписатьАтрибут("name", ИмяВыгружаемойБазы);
				ЗаписьXML.ЗаписатьКонецЭлемента();
				ЗаписьXML.ЗаписатьКонецЭлемента();
				НетЭлементов = Ложь;
			КонецЕсли;
			
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
		КонецЕсли;
	КонецЦикла;
	
	ЧтениеXML.Закрыть();
	ЗаписьXML.Закрыть();
	
	Попытка
		КопироватьФайл(НовыйФайлИнформацииОВыгрузках, СтруктураПодключенияЯндекс.РезервноеКопированиеФайлИнформацииОВыгрузках);
	Исключение
		ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
		Результат.ЕстьОшибки = Истина;
		Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
		Возврат;
	КонецПопытки;
	
	ВыгрузкаБазы = ВыгрузитьБазуВXML();
	
	Попытка
		КопироватьФайл(ВыгрузкаБазы, СтруктураПодключенияЯндекс.РезервноеКопированиеСтрокаПодключения + ИмяВыгружаемойБазы + ".xml");
	Исключение
		ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
		Результат.ЕстьОшибки = Истина;
		Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
		Возврат;
	КонецПопытки;
	
КонецПроцедуры

Процедура ВыгрузитьБазуНаУстройство(КаталогРезервногоКопирования, Результат)
	
	Каталог = Новый Файл(КаталогРезервногоКопирования);
	Если НЕ Каталог.Существует() Тогда
		Результат.ЕстьОшибки = Истина;
		Результат.Описание = НСтр("ru = 'Каталог резервного копирования не существует.
										|(Настройки - Резервное копирование)'");
		Возврат;
	КонецЕсли;
	
	ИмяВыгружаемойБазы = ИмяВыгружаемойБазы();
	
	ВыгрузкаБазы = ВыгрузитьБазуВXML();
	
	Попытка
		КопироватьФайл(ВыгрузкаБазы, ОбщегоНазначенияКлиентСервер.ДополнитьИмяКаталогаСлешем(КаталогРезервногоКопирования) + ИмяВыгружаемойБазы + ".xml");
	Исключение
		ТипОшибки = ИдентификацияОшибки(ИнформацияОбОшибке());
		Результат.ЕстьОшибки = Истина;
		Результат.Описание = ПолучитьОписаниеОшибки(ТипОшибки);
		Возврат;
	КонецПопытки;
	
КонецПроцедуры

Процедура УстановитьСтрокуПодключенияЯндекс(СтруктураПодключения)
	
	НаборКонстант = Константы.СоздатьНабор("КаталогЯндексРезервногоКопирования, ЛогинЯндексРезервногоКопирования, ПарольЯндексРезервногоКопирования");
	НаборКонстант.Прочитать();
	
	ЯндексДискСтрокаПодключения = "https://%user%:%password%@webdav.yandex.ru/";
	
	СтрокаПодключения = ЯндексДискСтрокаПодключения + НаборКонстант.КаталогЯндексРезервногоКопирования;
	ЯндексДискЛогин = СтрЗаменить(НаборКонстант.ЛогинЯндексРезервногоКопирования, "@yandex.ru", "");
	ЯндексДискЛогин = СтрЗаменить(НаборКонстант.ЛогинЯндексРезервногоКопирования, "@ya.ru", "");
	
	СтрокаПодключения = СтрЗаменить(СтрокаПодключения, "%user%", СокрЛП(ЯндексДискЛогин));
	СтрокаПодключения = СтрЗаменить(СтрокаПодключения, "%password%", НаборКонстант.ПарольЯндексРезервногоКопирования);
	
	Если Прав(СтрокаПодключения, 1) <> "/" Тогда 
		СтрокаПодключения = СтрокаПодключения + "/";
	КонецЕсли;
	
	СтруктураПодключения.Вставить("РезервноеКопированиеСтрокаПодключения", СтрокаПодключения);
	СтруктураПодключения.Вставить("РезервноеКопированиеФайлИнформацииОВыгрузках", СтрокаПодключения + "informationBases.xml");
	
КонецПроцедуры

Функция ПолучитьОписаниеОшибки(ТипОшибки)
	
	Если ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.ОшибкаАутентификации Тогда 
		ОписаниеОшибки = НСтр("ru='Неверно указан логин или пароль. Проверьте введенные данные.'");
	ИначеЕсли ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.НеверныйПуть Тогда 
		ОписаниеОшибки = НСтр("ru='Указана несуществующая папка. Проверьте введенные данные.'");
	ИначеЕсли ТипОшибки = Неопределено Тогда
		ОписаниеОшибки = НСтр("ru='Что-то пошло не так. Неизвестная ошибка.'");
	КонецЕсли;
	Возврат ОписаниеОшибки;
	
КонецФункции

Функция ВыгрузитьБазуВXML()
	
	ПутьФайлаВыгрузки = ПолучитьИмяВременногоФайла(".xml");
	
	ФайлВыгрузки = Новый ЗаписьXML;
	ФайлВыгрузки.ОткрытьФайл(ПутьФайлаВыгрузки);
	ФайлВыгрузки.ЗаписатьОбъявлениеXML();
	ФайлВыгрузки.ЗаписатьНачалоЭлемента("Документ");
	
	Для Каждого Элемент Из Константы Цикл
		
		ЭлементСтрокой = Строка(Элемент);
		
		Если НЕ Найти(ЭлементСтрокой, "Парол") = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Константа = Элемент.СоздатьМенеджерЗначения();
		Константа.Прочитать();
		ЗаписатьXML(ФайлВыгрузки, Константа, НазначениеТипаXML.Явное);
	КонецЦикла;
	
	Для Каждого Элемент Из Метаданные.Справочники Цикл
		МенеджерСправочника = Справочники[Элемент.Имя];
		ВыборкаСправочника = МенеджерСправочника.Выбрать();
		
		Пока ВыборкаСправочника.Следующий() Цикл 
			ЗаписатьXML(ФайлВыгрузки, ВыборкаСправочника.Ссылка.ПолучитьОбъект(), НазначениеТипаXML.Явное);
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого Элемент Из Метаданные.РегистрыСведений Цикл
		НаборЗаписей = РегистрыСведений[Элемент.Имя].СоздатьНаборЗаписей();
		НаборЗаписей.Прочитать();
		ЗаписатьXML(ФайлВыгрузки, НаборЗаписей, НазначениеТипаXML.Явное);
	КонецЦикла;
	
	Для Каждого Элемент Из Метаданные.РегистрыНакопления Цикл
		
		Менеджер = РегистрыНакопления[Элемент.имя];
		Выборка = менеджер.выбрать();
		
		НаборЗаписей = РегистрыНакопления[Элемент.Имя].СоздатьНаборЗаписей();
		
		Пока Выборка.Следующий() Цикл
			НаборЗаписей.Отбор.Регистратор.Установить(Выборка.Регистратор);
			НаборЗаписей.Прочитать();
			ЗаписатьXML(ФайлВыгрузки, НаборЗаписей, НазначениеТипаXML.Явное);
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого Элемент Из Метаданные.Документы Цикл

			МенеджерДокумента = Документы[Элемент.Имя];
			ВыборкаДокумента = МенеджерДокумента.Выбрать();
			
			Пока ВыборкаДокумента.Следующий() Цикл
				ЗаписатьXML(ФайлВыгрузки, ВыборкаДокумента.Ссылка.ПолучитьОбъект(), НазначениеТипаXML.Явное);
			КонецЦикла;

	КонецЦикла;
	
	ФайлВыгрузки.ЗаписатьКонецЭлемента();
	ФайлВыгрузки.Закрыть();
	
	Возврат ПутьФайлаВыгрузки;
	
КонецФункции

Функция ИдентификацияОшибки(ИнформацияОбОшибке)
	
	ТипОшибки = Неопределено;
	
	Пока ИнформацияОбОшибке <> Неопределено Цикл 
		
		Если Найти(ИнформацияОбОшибке.Описание, "аутентификац") <> 0 Тогда 
			ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.ОшибкаАутентификации;
			Возврат ТипОшибки;
		ИначеЕсли Найти(ИнформацияОбОшибке.Описание, "404") <> 0
			Или Найти(ИнформацияОбОшибке.Описание, "RETR failed") <> 0 Тогда 
			ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.ФайлНеНайден;
			Возврат ТипОшибки;
		ИначеЕсли Найти(ИнформацияОбОшибке.Описание, "409") <> 0 Тогда 
			ТипОшибки = Перечисления.РезервноеКопированиеПодключениеКСерверу.НеверныйПуть;
		КонецЕсли;
		
		ИнформацияОбОшибке = ИнформацияОбОшибке.Причина;
		
	КонецЦикла;
	
	Возврат ТипОшибки;
	
КонецФункции

Функция НаименованиеПриложения()
	
	Возврат "1CMobileCashDesk";
	
КонецФункции

Функция УстановитьСоответствиеСМетаданными(ВерсияПриложенияВыгрузка, ФайлВыгрузки)
	
	ДобавляемыеМетаданные = ТаблицаДобавляемыхМетаданных();
	ОпределитьДобавляемыеМетаданные(ВерсияПриложенияВыгрузка, ДобавляемыеМетаданные);
	
	ОбновляемыеОбъекты = ДобавляемыеМетаданные.Скопировать();
	ОбновляемыеОбъекты.Свернуть("ОбъектМетаданных");
	МассивОбновляемыхОбъектов = ОбновляемыеОбъекты.ВыгрузитьКолонку("ОбъектМетаданных");
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ФайлВыгрузки);
	
	ОбновленныйФайлВыгрузки = ПолучитьИмяВременногоФайла(".xml");
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(ОбновленныйФайлВыгрузки);
	
	НеобходимоДобавитьРеквизит = Ложь;
	ИмяОбновляемогоЭлементаXML = "";
	ИмяОбновляемогоЭлемента = "";
	
	Пока ЧтениеXML.Прочитать() Цикл
		
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда 
			
			Для каждого ОбновляемыйОбъект Из МассивОбновляемыхОбъектов Цикл 
				Если ИзXMLТипа(ПолучитьXMLТип(ЧтениеXML)) = Тип(ОбновляемыйОбъект) Тогда 
					НеобходимоДобавитьРеквизит = Истина;
					ИмяОбновляемогоЭлементаXML = ПолучитьXMLТип(ЧтениеXML).ИмяТипа;
					ИмяОбновляемогоЭлемента = ОбновляемыйОбъект;
				КонецЕсли;
			КонецЦикла;
			
			Если НеобходимоДобавитьРеквизит Тогда
				
				ТабличныеЧасти = Метаданные.НайтиПоТипу(Тип(ИмяОбновляемогоЭлемента)).ТабличныеЧасти;
				Для каждого ТабличнаяЧасть Из ТабличныеЧасти Цикл 
					Если ЧтениеXML.Имя = ТабличнаяЧасть.Имя Тогда 
						ДобавляемыеРеквизиты = ДобавляемыеМетаданные.НайтиСтроки(Новый Структура("ОбъектМетаданных", ИмяОбновляемогоЭлемента));
						Для Каждого Реквизит Из ДобавляемыеРеквизиты Цикл 
							ДобавитьНовыйРеквизит(ЗаписьXML, Реквизит.Реквизит, Реквизит.Значение);
						КонецЦикла;
						
						НеобходимоДобавитьРеквизит = Ложь;
					КонецЕсли;
				КонецЦикла;
				
				ЗаписьXML.ЗаписатьНачалоЭлемента(ЧтениеXML.Имя);
				Пока ЧтениеXML.ПрочитатьАтрибут() Цикл
					ЗаписьXML.ЗаписатьАтрибут(ЧтениеXML.Имя, ЧтениеXML.Значение);
				КонецЦикла;
				
				ДобавляемыеРеквизиты = ДобавляемыеМетаданные.НайтиСтроки(Новый Структура("ОбъектМетаданных", ИмяОбновляемогоЭлемента));
				Для каждого Реквизит Из ДобавляемыеРеквизиты Цикл
					Если ЧтениеXML.Имя = Реквизит.Реквизит Тогда
						ДобавитьНовыеАтрибутыРеквизиту(ЗаписьXML, Реквизит.Атрибуты);
						НеобходимоДобавитьРеквизит = Ложь;
					КонецЕсли;
				КонецЦикла;
				
			Иначе 
				ЗаписьXML.ЗаписатьНачалоЭлемента(ЧтениеXML.Имя);
				
				Пока ЧтениеXML.ПрочитатьАтрибут() Цикл
					ЗаписьXML.ЗаписатьАтрибут(ЧтениеXML.Имя, ЧтениеXML.Значение);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.Текст Тогда
			ЗаписьXML.ЗаписатьТекст(ЧтениеXML.Значение);
		КонецЕсли;
		
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.КонецЭлемента Тогда
			
			Если НеобходимоДобавитьРеквизит И ЧтениеXML.Имя = ИмяОбновляемогоЭлементаXML Тогда 
				ДобавляемыеРеквизиты = ДобавляемыеМетаданные.НайтиСтроки(Новый Структура("ОбъектМетаданных", ИмяОбновляемогоЭлемента));
				Для каждого Реквизит Из ДобавляемыеРеквизиты Цикл
					ДобавитьНовыйРеквизит(ЗаписьXML, Реквизит.Реквизит, Реквизит.Значение);
				КонецЦикла;
				
				НеобходимоДобавитьРеквизит = Ложь;
			КонецЕсли;
			
			ЗаписьXML.ЗаписатьКонецЭлемента();
			
		КонецЕсли;
	КонецЦикла;
	
	ЧтениеXML.Закрыть();
	ЗаписьXML.Закрыть();
	
	Возврат ОбновленныйФайлВыгрузки;
	
КонецФункции

Процедура ОпределитьДобавляемыеМетаданные(ВерсияПриложенияВыгрузка, ДобавляемыеМетаданные)
	
	//
	
КонецПроцедуры

Функция ТаблицаДобавляемыхМетаданных()
	
	ТаблицаДобавляемыхМетаданных = Новый ТаблицаЗначений;
	ТаблицаДобавляемыхМетаданных.Колонки.Добавить("ОбъектМетаданных");
	ТаблицаДобавляемыхМетаданных.Колонки.Добавить("Реквизит");
	ТаблицаДобавляемыхМетаданных.Колонки.Добавить("Значение");
	ТаблицаДобавляемыхМетаданных.Колонки.Добавить("Атрибуты", Новый ОписаниеТипов("СписокЗначений"));
	
	Возврат ТаблицаДобавляемыхМетаданных;
	
КонецФункции

Процедура ДобавитьНовыйРеквизит(ЗаписьXML, Наименование, Значение)
	
	ЗаписьXML.ЗаписатьНачалоЭлемента(Наименование);
	ЗаписьXML.ЗаписатьТекст(Значение);
	ЗаписьXML.ЗаписатьКонецЭлемента();
	
КонецПроцедуры

Процедура ДобавитьНовыеАтрибутыРеквизиту(ЗаписьXML, Атрибуты)
	
	Для каждого Атрибут Из Атрибуты Цикл 
		ЗаписьXML.ЗаписатьАтрибут(Атрибут.Представление, Атрибут.Значение);
	КонецЦикла;
	
КонецПроцедуры

Функция ИмяВыгружаемойБазы()
	
	ИмяВыгружаемойБазы = НаименованиеПриложения() + "_" + Метаданные.Версия + "_infoBase_" + Формат(ОбщегоНазначенияКлиентСервер.ПолучитьТекущуюДату(), "ДФ=yyyyMMdd_HHmmss");
	
	Возврат ИмяВыгружаемойБазы;
	
КонецФункции

Процедура ДобавитьФайлВТаблицуВыгруженныхБаз(ФайлИнформацииОВыгрузкахЛокальный, ВыгруженныеБазы)
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ФайлИнформацииОВыгрузкахЛокальный);
	
	ПостроительDOM = Новый ПостроительDOM;
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	ЧтениеXML.Закрыть();
	
	СтрокаXPath = "/applications/application[@name='" + НаименованиеПриложения() + "']/InformationBase";
	
	ВыражениеXPath = ДокументDOM.СоздатьВыражениеXPath(СтрокаXPath, Новый РазыменовательПространствИменDOM(ДокументDOM));
	РезультатXPath = ВыражениеXPath.Вычислить(ДокументDOM);
	
	ИнформационнаяБаза = РезультатXPath.ПолучитьСледующий();
	ВыгруженнаяБаза = Новый Структура;
	
	Пока ИнформационнаяБаза <> Неопределено Цикл 
		
		ИмяФайла = ИнформационнаяБаза.Атрибуты.ПолучитьИменованныйЭлемент("name").Значение;
		ВерсияПриложения = ИнформационнаяБаза.РодительскийУзел.Атрибуты.ПолучитьИменованныйЭлемент("version").Значение;
		
		РеквизитФайла = РазобратьИмяФайлаРезервнойКопии(ИмяФайла);
		
		Представление = НСтр("ru = 'Копия на Яндекс.Диск от %ДатаВыгрузки%'");
		Представление = СтрЗаменить(Представление, "%ДатаВыгрузки%", Формат(РеквизитФайла.ДатаВыгрузки, "ДФ='dd.MM.yyyy HH:mm:ss'"));

		ВыгруженнаяБаза = Новый Структура;
		
		ВыгруженнаяБаза.Вставить("ИмяФайла",         ИмяФайла);
		ВыгруженнаяБаза.Вставить("Представление",    Представление);
		ВыгруженнаяБаза.Вставить("ВерсияПриложения", РеквизитФайла.Версия);
		ВыгруженнаяБаза.Вставить("ДатаВыгрузки",     РеквизитФайла.ДатаВыгрузки);
		ВыгруженнаяБаза.Вставить("МестоХранения",    "ЯндексДиск");
		
		ВыгруженныеБазы.Добавить(ВыгруженнаяБаза);
		
		ИнформационнаяБаза = РезультатXPath.ПолучитьСледующий();
	КонецЦикла;
	
КонецПроцедуры

Функция РазобратьИмяФайлаРезервнойКопии(Знач ИмяФайла)
	
	Результат = Новый Структура;
	
	ИмяФайла = СтрЗаменить(ИмяФайла, ".xml", "");
	
	ИмяФайлаБезИмениПриложения = СтрЗаменить(ИмяФайла, НаименованиеПриложения() + "_", "");
	
	НомерСимволаПодчеркивание = Найти(ИмяФайлаБезИмениПриложения, "_");
	
	Версия = Лев(ИмяФайлаБезИмениПриложения, НомерСимволаПодчеркивание-1);
	
	КоличествоСимволовВДатеВремени = 15;
	ДатаВремяСтрокой = Прав(ИмяФайла, КоличествоСимволовВДатеВремени);
	ДатаВремяСтрокой = СтрЗаменить(ДатаВремяСтрокой, "_", "");
	
	Попытка
		ДатаВыгрузки = Дата(ДатаВремяСтрокой);
	Исключение
		ДатаВыгрузки = Дата("00010101");
	КонецПопытки;
	
	
	Результат.Вставить("Версия", Версия);
	Результат.Вставить("ДатаВыгрузки", ДатаВыгрузки);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти


