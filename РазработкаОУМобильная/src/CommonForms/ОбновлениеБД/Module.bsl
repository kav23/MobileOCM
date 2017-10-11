
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	НастроитьФормуПоЗначениямНастроек();
	
	//ОриентацияЭкрана
	НастроитьФормуПоОриентацииЭкрана();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииПараметровЭкрана()
	
	//ОриентацияЭкрана
	ПриИзмененииПараметровЭкранаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("Подключаемый_ПриОткрытии", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Отказ = ИдетПроцессОбновления;
	
	Если НЕ Отказ Тогда
		Закрыть(ОбновлениеУспешно);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Подключаемый_ПриОткрытии()
	
	ИдетПроцессОбновления = Истина;
	ОбновитьБД();
	
	Оповестить("ИзмененыЗначенияНастроек");
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоЗначениямНастроек()
	
	ОбщегоНазначения.УстановитьШрифт(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьБД()
	Отказ = Ложь;
	Лог = "";
	ОбновлениеБД.ОбновитьБазуДанных(Отказ, Лог);
	
	ИдетПроцессОбновления = Ложь;
	Если Отказ Тогда
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаОшибка;
		ВывестиЛог(Лог);
	Иначе
		Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаУспешно;
		ОбновлениеУспешно = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ВывестиЛог(Лог)
	
	ЛогHTML = "<html>
	|<body>";
	
	ЛогHTML = ЛогHTML + Лог;
	
	ЛогHTML = ЛогHTML + "
	|</body>
	|</html>
	|";
	
КонецПроцедуры

#КонецОбласти

#Область ОриентацияЭкрана

//ОриентацияЭкрана
&НаСервере
Процедура ПриИзмененииПараметровЭкранаСервер()
	
	ОбщегоНазначения.УстановитьОриентациюЭкрана();
	НастроитьФормуПоОриентацииЭкрана();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоОриентацииЭкрана()
	
КонецПроцедуры

#КонецОбласти
