Процедура СозданиеОбраза(МобУстр) Экспорт
	Узел = ПланыОбмена.ОС_ОбменСМобильнымиУстройствами.ПолучитьСсылку(МобУстр.УникальныйИдентификатор());
	Запрос = Новый Запрос();
	Текст = "";
	Для Каждого ЭлСостава Из Метаданные.ПланыОбмена.ОС_ОбменСМобильнымиУстройствами.Состав Цикл
		Если ЭлСостава.АвтоРегистрация = АвтоРегистрацияИзменений.Разрешить Тогда
			ПланыОбмена.ЗарегистрироватьИзменения(Узел,ЭлСостава.Метаданные);
		Иначе
			Если ЭлСостава.Метаданные = Метаданные.РегистрыСведений.Штрихкоды Тогда
				ПланыОбмена.ЗарегистрироватьИзменения(Узел,ЭлСостава.Метаданные);
				ОтборыПоРегиструШтрихкодов(Узел);
			Иначе
				Текст = Текст + "Выбрать Об.Ссылка КАК Объект ИЗ " + ЭлСостава.Метаданные.ПолноеИмя() + " КАК Об Объединить ВСЕ ";
			КонецЕсли;
			
		КонецЕсли;
	КонецЦикла;
	
	Запрос.Текст = Лев(Текст, СтрДлина(Текст) - 16);
	
	МассивОбъектов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Объект");
	
	Для Каждого Эл Из МассивОбъектов Цикл
		ПоставитьОбъектВОчередьВыгрузки(Эл, Ложь, МобУстр, Узел)	
	КонецЦикла;

КонецПроцедуры

Процедура ПоставитьОбъектВОчередьВыгрузки(Источник, Отказ, МобУстр = Неопределено, Узел = Неопределено) Экспорт
	Если Отказ Тогда Возврат КонецЕсли;
	СсылкаНаОбъект = Источник.Ссылка;
	Запрос = Новый Запрос;
#Область ГлобальныйОтборНаВсеУстройства	
	Если ТипЗнч(СсылкаНаОбъект) = Тип("СправочникСсылка.ЕдиницыИзмерения") Тогда
		Если  ТипЗнч(СсылкаНаОбъект.Владелец) <> Тип("СправочникСсылка.Номенклатура") Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
#КонецОбласти

#Область ЛокальныйОтборНаВсеУстройства	
	Если ТипЗнч(СсылкаНаОбъект) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОС_МобильныеУстройстваСрезПоследних.Узел КАК Узел
		|ИЗ
		|	РегистрСведений.ОС_МобильныеУстройства.СрезПоследних(, Пользователь = &Пользователь " + ?(ЗначениеЗаполнено(Узел)," И Узел = &Узел","") + ") КАК ОС_МобильныеУстройстваСрезПоследних";
		
		Запрос.УстановитьПараметр("Пользователь", СсылкаНаОбъект.Ответственный);
	Иначе
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОС_ОбменСМобильнымиУстройствами.Ссылка КАК Узел
		|ИЗ
		|	ПланОбмена.ОС_ОбменСМобильнымиУстройствами КАК ОС_ОбменСМобильнымиУстройствами" + ?(ЗначениеЗаполнено(Узел)," ГДЕ Ссылка = &Узел","") + "";		
	КонецЕсли;
#КонецОбласти
	Запрос.УстановитьПараметр("Узел", Узел);
	МассивУзлов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Узел");

	 ЗаписатьРегистрацию(МассивУзлов, Источник)
КонецПроцедуры

Процедура ОС_РегистрацияИзмененийДляРегистровСведенийПриЗаписи(Источник, Отказ, Замещение, Узел = Неопределено) Экспорт
	Если Отказ Тогда Возврат КонецЕсли;
	Если ТипЗнч(Источник) = Тип("РегистрСведенийНаборЗаписей.Штрихкоды") Тогда

		Если ТипЗнч(Источник.Отбор.Владелец.Значение) <> Тип("СправочникСсылка.Номенклатура") Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОС_ОбменСМобильнымиУстройствами.Ссылка КАК Узел
		|ИЗ
		|	ПланОбмена.ОС_ОбменСМобильнымиУстройствами КАК ОС_ОбменСМобильнымиУстройствами" + ?(ЗначениеЗаполнено(Узел)," ГДЕ Ссылка = &Узел","") + "";		
	Запрос.УстановитьПараметр("Узел", Узел);
	МассивУзлов = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Узел");

	ЗаписатьРегистрацию(МассивУзлов, Источник);
КонецПроцедуры

Процедура ЗаписатьРегистрацию(МассивУзлов, Источник)
	
	ИндексЭтогоУзла = МассивУзлов.Найти(ПланыОбмена.ОС_ОбменСМобильнымиУстройствами.ЭтотУзел());
	Если НЕ ИндексЭтогоУзла = Неопределено Тогда
		МассивУзлов.Удалить(ИндексЭтогоУзла);
	КонецЕсли;
	Если МассивУзлов.Количество() = 0 Тогда Возврат КонецЕсли;
	
	ПланыОбмена.ЗарегистрироватьИзменения(МассивУзлов, Источник);	
КонецПроцедуры

Процедура ОтборыПоРегиструШтрихкодов(Узел)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ШтрихкодыИзменения.Владелец,
		|	ШтрихкодыИзменения.Штрихкод,
		|	ШтрихкодыИзменения.ТипШтрихкода,
		|	ШтрихкодыИзменения.ЕдиницаИзмерения,
		|	ШтрихкодыИзменения.ХарактеристикаНоменклатуры
		|ИЗ
		|	РегистрСведений.Штрихкоды.Изменения КАК ШтрихкодыИзменения
		|ГДЕ
		|	ШтрихкодыИзменения.Узел = &Узел
		|	И НЕ ШтрихкодыИзменения.Владелец ССЫЛКА Справочник.Номенклатура";

	Запрос.УстановитьПараметр("Узел", Узел);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НовНабор = РегистрыСведений.Штрихкоды.СоздатьНаборЗаписей();
		НовНабор.Отбор.Владелец.Установить(ВыборкаДетальныеЗаписи.Владелец);
		НовНабор.Отбор.Штрихкод.Установить(ВыборкаДетальныеЗаписи.Штрихкод);
		НовНабор.Отбор.ТипШтрихкода.Установить(ВыборкаДетальныеЗаписи.ТипШтрихкода);
		НовНабор.Отбор.ЕдиницаИзмерения.Установить(ВыборкаДетальныеЗаписи.ЕдиницаИзмерения);
		НовНабор.Отбор.ХарактеристикаНоменклатуры.Установить(ВыборкаДетальныеЗаписи.ХарактеристикаНоменклатуры);
		
		ПланыОбмена.УдалитьРегистрациюИзменений(Узел,НовНабор);
	КонецЦикла;
КонецПроцедуры

Процедура ЗаписатьПараметрыПредупреждения(ПараметрыПредупреждения) Экспорт
	ПараметрыПредупреждения = Новый ХранилищеЗначения(ПараметрыПредупреждения);
	ПараметрыСеанса.ПараметрыПредупреждения = ПараметрыПредупреждения;
КонецПроцедуры

Функция ПолучитьИменаКолонокВерсииОтборВерсия() Экспорт
	Имена = Новый Структура;

	//Имена.Вставить("ПоСвойствам");
	//Имена.Вставить("РабочийЦентр");
	Имена.Вставить("Номенклатура");
	Имена.Вставить("МаркаСплава");
	Имена.Вставить("ГруппаПродукции");
	Имена.Вставить("ХарактеристикаНоменклатуры");
	//Имена.Вставить("СерияНоменклатуры");
	//Имена.Вставить("Состояние");
	Имена.Вставить("Коэффициент");
	Имена.Вставить("Коэффициент1");
	//Имена.Вставить("ЕдиницаИзмерения1");
	//Имена.Вставить("ПаспортПартии");
	Имена.Вставить("Количество");
	Имена.Вставить("Количество1");
	Имена.Вставить("КоличествоМест");
	Имена.Вставить("Тара");
	Имена.Вставить("КоличествоТара");
	//Имена.Вставить("Размер1");
	//Имена.Вставить("Размер2");
	//Имена.Вставить("Размер3");
	//Имена.Вставить("Размер4");
	//Имена.Вставить("Размер5");
	//Имена.Вставить("ДополнительнаяИнформация");
	//Имена.Вставить("Маркировка");
	//Имена.Вставить("ОбъемПогонногоМетра");
	
	//Если Версия >= "003" тогда
	//	Имена.Вставить("ЕдиницаИзмерения");
	//КонецЕсли;
	
	Возврат( Имена);
КонецФункции

Функция ПараметрыПредупреждения() Экспорт
	ПараметрыПредупреждения = ПараметрыСеанса.ПараметрыПредупреждения.Получить();
	Возврат ПараметрыПредупреждения;
КонецФункции

Функция ПолучитьКонстанту(ИмяКонстанты) Экспорт
	РедактироватьКоличествоПослеСканирования = Константы[ИмяКонстанты].Получить();
	Возврат РедактироватьКоличествоПослеСканирования;
КонецФункции

Функция ПредставлениеПартии(ДанныеСтрокиПаспортПартии) Экспорт
	СтрокаРезультат = "";
	Если ТипЗнч(ДанныеСтрокиПаспортПартии) = Тип("ДокументСсылка.УГМК_Регистратор") Тогда
		СтрокаРезультат = ДанныеСтрокиПаспортПартии.Номер;
	КонецЕсли;
	Возврат СтрокаРезультат;
КонецФункции

Функция РассчитатьПоФормуле(Свойства,ТекФормула) Экспорт
	рез=0;
	Выполнить("рез="+ТекФормула);
	Возврат рез;
КонецФункции

Функция СтруктураОсновныхДанных_Сервер()
	ТекущиеДанные = Новый Структура("Номенклатура,ХарактеристикаНоменклатуры,ПоСвойствам,ГруппаПродукции,МаркаСплава,Состояние,ДополнениеИмени,Дополнительно");
	Возврат ТекущиеДанные;	
КонецФункции

Функция ПринтерПоУмолчанию() Экспорт
	ПринтерПоУмолчанию = Неопределено;
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПринтерПоУмолчанию.Принтер КАК Принтер
	               |ИЗ
	               |	РегистрСведений.ПринтерПоУмолчанию КАК ПринтерПоУмолчанию
	               |ГДЕ
	               |	ПринтерПоУмолчанию.Пользователь = &Пользователь";
	Попытка
		ТекущийПользователь = ПараметрыСеанса.ТекущийПользователь;
	Исключение
		ТекущийПользователь = Справочники.Пользователи.ПустаяСсылка();	
	КонецПопытки;	
	Запрос.Параметры.Вставить("Пользователь", ТекущийПользователь);
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаЗапроса = РезультатЗапроса.Выбрать();
	Если ВыборкаЗапроса.Следующий() Тогда
		ПринтерПоУмолчанию = ВыборкаЗапроса.Принтер;
	КонецЕсли;	
	Возврат ПринтерПоУмолчанию;	
КонецФункции

Процедура ЗаписатьПринтерПоУмолчанию(Принтер, Пользователь = Неопределено, Очистить = Ложь) Экспорт
	 
	Если Пользователь = Неопределено Тогда
		Попытка
			Пользователь = ПараметрыСеанса.ТекущийПользователь;
		Исключение
			Пользователь = Справочники.Пользователи.ПустаяСсылка();	
		КонецПопытки;	
	КонецЕсли;	
	НаборЗаписей = РегистрыСведений.ПринтерПоУмолчанию.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(Пользователь);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	Если НЕ Очистить Тогда
		НоваяЗапись = НаборЗаписей.Добавить();
		НоваяЗапись.Пользователь = Пользователь;
		НоваяЗапись.Принтер = Принтер;
	КонецЕсли;
	НаборЗаписей.Записать();
КонецПроцедуры

