
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗаполнитьЗначенияСвойств( ЭтаФорма, Параметры, "Оснастка1,Оснастка2,Оснастка3,РабочийЦентр,УГМК_ТипТехоснастки");
	
	ОбновитьЗаголовкиСервер();
	
	УГМК_ОперативныйУчетВызовСервера.ОбработатьШрифтыФормы( ЭтаФорма, Новый Структура("ГруппаДействия"));
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовкиСервер()
	Элементы.РабочийЦентр.Заголовок = Строка( РабочийЦентр);
	Элементы.УГМК_ТипТехоснастки.Заголовок = Строка( УГМК_ТипТехоснастки);
	Элементы.Оснастка1.Заголовок = Строка( Оснастка1);
	Элементы.Оснастка2.Заголовок = Строка( Оснастка2);
	Элементы.Оснастка3.Заголовок = Строка( Оснастка3);
КонецПроцедуры

&НаКлиенте
Процедура ОснасткаВыбор( ИмяЭлемента)
	ПараметрыВ = Новый Структура;
	ПараметрыВ.Вставить("РабочийЦентр", РабочийЦентр);
	ПараметрыВ.Вставить("УГМК_ТипТехоснастки", УГМК_ТипТехоснастки);
	ПараметрыВ.Вставить("ТекущаяСтрока", ЭтаФорма[ ИмяЭлемента]);
	
	НоваяОснастка = ОткрытьФормуМодально("Справочник.УГМК_ТехнологическаяОснастка.Форма.ФормаВыбора", ПараметрыВ, ЭтаФорма);
	Если ЗначениеЗаполнено( НоваяОснастка) Тогда
		ЭтаФорма[ ИмяЭлемента] = НоваяОснастка;
		Элементы[ ИмяЭлемента].Заголовок = Строка( НоваяОснастка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РабочийЦентр(Команда)
	ПараметрыВ = Новый Структура;
	ПараметрыВ.Вставить("ТекущаяСтрока", РабочийЦентр);
	РабочийЦентрРез = ОткрытьФормуМодально("Справочник.РабочиеЦентры.Форма.ФормаВыбораУправляемая", ПараметрыВ, ЭтаФорма);
	Если ЗначениеЗаполнено( РабочийЦентрРез) Тогда
		РабочийЦентр = РабочийЦентрРез;
		ОбновитьЗаголовкиСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТипОснастки(Команда)
	ПараметрыВ = Новый Структура;
	ПараметрыВ.Вставить("РабочийЦентр", РабочийЦентр);
	ПараметрыВ.Вставить("ТекущаяСтрока", УГМК_ТипТехоснастки);
	УГМК_ТипТехоснасткиРез = ОткрытьФормуМодально("Справочник.УГМК_ТипыТехнологическихОснасток.Форма.ФормаВыбора", ПараметрыВ, ЭтаФорма);
	Если ЗначениеЗаполнено( УГМК_ТипТехоснасткиРез) Тогда
		УГМК_ТипТехоснастки = УГМК_ТипТехоснасткиРез;
		ОбновитьЗаголовкиСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Оснастка1(Команда)
	ОснасткаВыбор("Оснастка1");
КонецПроцедуры

&НаКлиенте
Процедура Оснастка2(Команда)
	ОснасткаВыбор("Оснастка2");
КонецПроцедуры

&НаКлиенте
Процедура Оснастка3(Команда)
	ОснасткаВыбор("Оснастка3");
КонецПроцедуры

&НаКлиенте
Процедура РЦОчистить(Команда)
	РабочийЦентр = Неопределено;
	ОбновитьЗаголовкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура ТипОснасткиОчистить(Команда)
	УГМК_ТипТехоснастки = Неопределено;
	ОбновитьЗаголовкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура Оснастка1Очистить(Команда)
	Оснастка1 = Неопределено;
	ОбновитьЗаголовкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура Оснастка2Очистить(Команда)
	Оснастка2 = Неопределено;
	ОбновитьЗаголовкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура Оснастка3Очистить(Команда)
	Оснастка3 = Неопределено;
	ОбновитьЗаголовкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	Результат = Новый Структура("РабочийЦентр,Оснастка1,Оснастка2,Оснастка3");
	ЗаполнитьЗначенияСвойств( Результат, ЭтаФорма);
	Закрыть( Результат);
КонецПроцедуры
