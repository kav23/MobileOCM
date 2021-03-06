
&НаКлиенте
Процедура ОткрытьОписьМеталла(Команда)
	ОткрытьФорму("Документ.УГМК_ДокументФакт.ФормаСписка",,,,,,,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);	
КонецПроцедуры


&НаКлиенте
Процедура ОчиститьДокументы(Команда)
	
	УдалитьДокументы();
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаСервере
Процедура УдалитьДокументы() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	УГМК_ДокументФакт.Ссылка
	               |ИЗ
	               |	Документ.УГМК_ДокументФакт КАК УГМК_ДокументФакт";
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		ДокументОбъект = Выборка.Ссылка.ПолучитьОбъект();
		ДокументОбъект.Удалить();
	КонецЦикла;	// Вставить содержимое обработчика.
КонецПроцедуры


&НаКлиенте
Процедура Выход(Команда)
	КодОтвета = Вопрос("Выйти из приложения?", РежимДиалогаВопрос.ДаНет, 10, КодВозвратаДиалога.Нет);
	Если КодОтвета = КодВозвратаДиалога.Да Тогда
		ЗавершитьРаботуСистемы();
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьДокументы(Команда)
	ОтправитьДокументыСервер();	
КонецПроцедуры


&НаСервере
Процедура ОтправитьДокументыСервер()
	Выборка = Документы.УГМК_ДокументФакт.Выбрать();
	Пока Выборка.Следующий() Цикл
		Обмен.ОтправитьДокумент(Выборка.Ссылка);	
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеКВебСервису(Команда)
	ОткрытьФорму("ОбщаяФорма.АдресВебСервиса",,,,,,,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНавеска(Команда)
	ОткрытьФорму("Документ.УГМК_ДокументФакт.Форма.ФормаСпискаМобильнаяНавеска",,,,,,,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);	
КонецПроцедуры

&НаКлиенте
Процедура УзлыОбмена(Команда)
	ОткрытьФорму("ПланОбмена.УГМК_ОбменСМобильнымиУстройствами.ФормаСписка");	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаСканирования(Команда)
	ОткрытьФорму("ОбщаяФорма.НастройкиОбщие");
КонецПроцедуры

&НаКлиенте
Процедура МенюОперации(Команда)
	ОткрытьФорму("ОбщаяФорма.ФормаОперации");
	//МассивВидимыхГрупп = Новый Массив;
	//МассивВидимыхГрупп.Добавить(Элементы.ГруппаОперации);
	// УправлениеВидимостью(МассивВидимыхГрупп);
КонецПроцедуры

&НаКлиенте
Процедура МенюОбменСЦБ(Команда)
	ОткрытьФорму("ОбщаяФорма.ФормаОбменЦБ");
	//МассивВидимыхГрупп = Новый Массив;
	//МассивВидимыхГрупп.Добавить(Элементы.ГруппаОбмен);
	// УправлениеВидимостью(МассивВидимыхГрупп);
КонецПроцедуры

&НаКлиенте
Процедура МенюНастройки(Команда)
	ОткрытьФорму("ОбщаяФорма.ФормаГруппаНастройки");
	//МассивВидимыхГрупп = Новый Массив;
	//МассивВидимыхГрупп.Добавить(Элементы.ГруппаНастройки);
	// УправлениеВидимостью(МассивВидимыхГрупп);
КонецПроцедуры

&НаКлиенте
Процедура КнопкаАвторизацииНажатие(Элемент)
	Элементы.КнопкаАвторизации.Заголовок = Элементы.КнопкаАвторизации.Заголовок + "1";
КонецПроцедуры


#Область ОбработчикиСобытийФормы


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		НастроитьФормуПоЗначениямНастроек();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененыЗначенияНастроек" ИЛИ ИмяСобытия = "ВыполненОбмен" Тогда
		
		НастроитьФормуПоЗначениямНастроек();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура НастроитьФормуПоЗначениямНастроек()
	
	ОбщегоНазначения.УстановитьШрифт(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти


//&НаКлиенте
//Процедура УправлениеВидимостью(МассивВидимыхГрупп)
//	МассивВсехГрупп = Новый Массив;
//	МассивВсехГрупп.Добавить(Элементы.ОсновноеМеню);
//	МассивВсехГрупп.Добавить(Элементы.ГруппаОперации);
//	МассивВсехГрупп.Добавить(Элементы.ГруппаОбмен);
//	МассивВсехГрупп.Добавить(Элементы.ГруппаНастройки);
//	Для Каждого Элемент из МассивВсехГрупп Цикл
//		Если МассивВидимыхГрупп.Найти(Элемент) = Неопределено Тогда
//			Элемент.Видимость = Ложь;
//		Иначе
//			Элемент.Видимость = Истина;
//		КонецЕсли;	
//	КонецЦикла;	
//КонецПроцедуры

//&НаКлиенте
//Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
//	Если НЕ Элементы.ОсновноеМеню.Видимость Тогда
//		СтандартнаяОбработка = Ложь;
//		Отказ = Истина;
//		МассивВидимыхГрупп = Новый Массив;
//		МассивВидимыхГрупп.Добавить(Элементы.ОсновноеМеню);
//		УправлениеВидимостью(МассивВидимыхГрупп);
//		Возврат;
//	КонецЕсли;	
//	//Отказ = Элементы.ГруппаВвестиКоличество.Видимость;
//КонецПроцедуры


//&НаКлиенте
//Процедура ПриОткрытии(Отказ)
//		МассивВидимыхГрупп = Новый Массив;
//		МассивВидимыхГрупп.Добавить(Элементы.ОсновноеМеню);
//		УправлениеВидимостью(МассивВидимыхГрупп);
//КонецПроцедуры

