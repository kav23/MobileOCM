Функция ПредставлениеСтрокиКлиентКратко(ДанныеСтрокиЗапись) Экспорт
	СтрокаПредставление = "";
	Если ДанныеСтрокиЗапись.ПоСвойствам Тогда 
		 //Строка(ДанныеСтрокиЗапись.МаркаСплава) + " ; " + 
					СтрокаПредставление =  Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ; "
												+ Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " ; "
												+ Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + " ; "
												+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " ; "
												+ Строка(ДанныеСтрокиЗапись.Тара) + " ; "
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " ; ";
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
																	
		
	Иначе	
							СтрокаПредставление = Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ; "
												+ Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " ; "
												+ Строка(ДанныеСтрокиЗапись.Номенклатура) + " ; "
												+ Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + " ; "
												+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " ; "
												+ Строка(ДанныеСтрокиЗапись.Тара) + " ; "
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " ; ";
												//+ Строка(ДанныеСтрокиЗапись.Тара) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
	
											КонецЕсли;	
											
	Возврат СтрокаПредставление;
КонецФункции

Функция ПредставлениеСтрокиКлиентHTML(ДанныеСтрокиЗапись) Экспорт
	СтрокаПредставление = "";
	Если ДанныеСтрокиЗапись.ПоСвойствам Тогда 
		 //Строка(ДанныеСтрокиЗапись.МаркаСплава) + " ; " + 
		 		СтрокаПредставление = "<P><FONT size=6 face=Verdana> Партия " + УГМК_МобильныеУстройства.ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " </FONT></P>"
												+ "<P><FONT size=5 face=Verdana> " + Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " "
												+ Строка(ДанныеСтрокиЗапись.МаркаСплава) + " "
												+ Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + " </FONT></P>"
												//+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " </FONT></P>"
												//+ Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ;"
												//+ "|<P><FONT size=4 face=Verdana> " + Строка(ДанныеСтрокиЗапись.Тара) + " ; </FONT></P>"
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " </FONT></P>";
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
																	
		
	Иначе	
		 		СтрокаПредставление = "|<P><FONT size=6 face=Verdana> " + УГМК_МобильныеУстройства.ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " </FONT></P>"
												//+ Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ; </FONT></P>"
												//+ Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " ; </FONT></P>"
												+ "<P><FONT size=5 face=Verdana> " + Строка(ДанныеСтрокиЗапись.Номенклатура) + " "
												+ Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + " </FONT></P>"
												//+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Тара) + " ; </FONT></P>"
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " </FONT></P>";
												//+ Строка(ДанныеСтрокиЗапись.Тара) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
	
											КонецЕсли;	
											
	Возврат СтрокаПредставление;
КонецФункции

Функция ПредставлениеСтрокиПредупреждение(ДанныеСтрокиЗапись) Экспорт
	СтрокаПредставление = "";
	Если ДанныеСтрокиЗапись.ПоСвойствам Тогда 
		 //Строка(ДанныеСтрокиЗапись.МаркаСплава) + " ; " + 
СтрокаПредставление = "Марка сплава:     " + Строка(ДанныеСтрокиЗапись.МаркаСплава) + "
			|Группа продукции: " + Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + "
			|Тара:             " + Строка(ДанныеСтрокиЗапись.Тара) + "
			|Характеристика:   " + Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + "
			|Серия:            " + Строка(ДанныеСтрокиЗапись.СерияНоменклатуры) + "
			|Маркировка:       " + Строка(ДанныеСтрокиЗапись.Маркировка) + "
			|Коэффициент:      " + Строка(ДанныеСтрокиЗапись.Коэффициент) + "
			|Количество:       " + Строка(ДанныеСтрокиЗапись.Количество) + "
			|Кол-во (доп.):    " + Строка(ДанныеСтрокиЗапись.Количество1) + "
			|Мест:             " + Строка(ДанныеСтрокиЗапись.КоличествоМест) + "
			|Кол-во (тара):    " + Строка(ДанныеСтрокиЗапись.КоличествоТара);
		
	Иначе	
СтрокаПредставление = "Номенклатура:     " + Строка(ДанныеСтрокиЗапись.Номенклатура) + "
			|Тара:             " + Строка(ДанныеСтрокиЗапись.Тара) + "
			|Характеристика:   " + Строка(ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры) + "
			|Серия:            " + Строка(ДанныеСтрокиЗапись.СерияНоменклатуры) + "
			|Маркировка:       " + Строка(ДанныеСтрокиЗапись.Маркировка) + "
			|Коэффициент:      " + Строка(ДанныеСтрокиЗапись.Коэффициент) + "
			|Количество:       " + Строка(ДанныеСтрокиЗапись.Количество) + "
			|Кол-во (доп.):    " + Строка(ДанныеСтрокиЗапись.Количество1) + "
			|Мест:             " + Строка(ДанныеСтрокиЗапись.КоличествоМест) + "
			|Кол-во (тара):    " + Строка(ДанныеСтрокиЗапись.КоличествоТара);
	КонецЕсли;	
	Возврат СтрокаПредставление;
КонецФункции

Функция ПредставлениеСтрокиКлиентHTMLПодтверждение(ДанныеСтрокиЗапись, ТаблЧастьПродукции = Ложь, size=" size=3") Экспорт
	СтрокаПредставление = "";
	Если ?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ПоСвойствамПродукции,ДанныеСтрокиЗапись.ПоСвойствам) Тогда 
		 //Строка(ДанныеСтрокиЗапись.МаркаСплава) + " ; " + 
		 		СтрокаПредставление = "<P><FONT " + size + " face=Verdana>" + УГМК_МобильныеУстройства.ПредставлениеПартии(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ПаспортПартииПродукции,ДанныеСтрокиЗапись.ПаспортПартии)) + " "
												+ Строка(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ГруппаПродукцииПродукции,ДанныеСтрокиЗапись.ГруппаПродукции)) + " "
												+ Строка(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.МаркаСплаваПродукции,ДанныеСтрокиЗапись.МаркаСплава)) + " "
												+ Строка(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ХарактеристикаПродукции,ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры)) + " </FONT></P>"
												//+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " </FONT></P>"
												//+ Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ;"
												//+ "|<P><FONT size=4 face=Verdana> " + Строка(ДанныеСтрокиЗапись.Тара) + " ; </FONT></P>"
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " </FONT></P>";
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
																	
		
	Иначе	
		 		СтрокаПредставление = "<P><FONT " + size + " face=Verdana> " + УГМК_МобильныеУстройства.ПредставлениеПартии(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ПаспортПартииПродукции,ДанныеСтрокиЗапись.ПаспортПартии)) + " "
												//+ Строка(ДанныеСтрокиЗапись.Количество1+ДанныеСтрокиЗапись.КоличествоТара) + " ; </FONT></P>"
												//+ Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " ; </FONT></P>"
												+ Строка(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.НоменклатураПродукции,ДанныеСтрокиЗапись.Номенклатура)) + " "
												+ Строка(?(ТаблЧастьПродукции,ДанныеСтрокиЗапись.ХарактеристикаНоменклатурыПродукции,ДанныеСтрокиЗапись.ХарактеристикаНоменклатуры)) + " </FONT></P>"
												//+ ?(ЗначениеЗаполнено(ДанныеСтрокиЗапись.СерияНоменклатуры),Строка(ДанныеСтрокиЗапись.СерияНоменклатуры),ДанныеСтрокиЗапись.СерияНоменклатурыПредставление) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Тара) + " ; </FONT></P>"
												//+ ПредставлениеПартии(ДанныеСтрокиЗапись.ПаспортПартии) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Коэффициент) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Количество1) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.КоличествоМест) + " </FONT></P>";
												//+ Строка(ДанныеСтрокиЗапись.Тара) + " ; "
												//+ Строка(ДанныеСтрокиЗапись.Маркировка);
	
											КонецЕсли;	
											
	Возврат СтрокаПредставление;
КонецФункции


Функция ПредставлениеСтрокиHTMLПередел(ДанныеСтрокиЗапись, size=" size=3") Экспорт
	СтрокаПредставление = "";
		 //Строка(ДанныеСтрокиЗапись.МаркаСплава) + " ; " + 
		 		СтрокаПредставление = "<P><FONT " + size + " face=Verdana>" + ДанныеСтрокиЗапись.Партия + " "
					+ Строка(ДанныеСтрокиЗапись.ГруппаПродукции) + " "
					+ Строка(ДанныеСтрокиЗапись.МаркаСплава) + " "
					+ Строка(ДанныеСтрокиЗапись.Размер) + " "
					+ Строка(ДанныеСтрокиЗапись.Состояние) + " "
					+ Строка(ДанныеСтрокиЗапись.Количество) + " </FONT></P>";
																	
											
	Возврат СтрокаПредставление;
КонецФункции


&НаСервере
Процедура ПоНарядуСервер(ТекущийПользователь, Организация) Экспорт
	Попытка
	ПараметрыСеанса.Ошибки = "Обращение прошло успешно";
	АдресВебСервиса = Константы.АдресВебСервиса.Получить();
	ПарольПользователя = Константы.ПарольПользователя.Получить();
	ПользовательЦентральнойБазы = Константы.ПользовательЦентральнойБазы.Получить();
	ВСОпределение = Новый WSОпределения(АдресВебСервиса,ПользовательЦентральнойБазы,ПарольПользователя); 
	ВСервис = ВСОпределение.Сервисы.Получить("MobileTransferStr","MobileTransfer"); 
	ВТочкаВхода = ВСервис.ТочкиПодключения.Получить("MobileTransferSoap"); 
	ВОперация = ВТочкаВхода.Интерфейс.Операции.Получить("GetIspolnitel"); 
	ВСПрокси = Новый WSПрокси(ВСОпределение, "MobileTransferStr","MobileTransfer","MobileTransferSoap");
	ВСПрокси.Пользователь = "update1c"; 
	ВСПрокси.Пароль = "St7658";
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Пользователь", ТекущийПользователь);
	СтруктураПараметров.Вставить("Организация", Организация);
	ДанныеСотрудники = ВСПрокси.GetIspolnitel(Новый ХранилищеЗначения(Сериализовать(СтруктураПараметров), Новый СжатиеДанных(9)));
	ПараметрыСеанса.ТекущиеИсполнители = ДанныеСотрудники;
Исключение
	Описаниеошибки = ОписаниеОшибки();
	ПараметрыСеанса.Ошибки = Описаниеошибки;
	КонецПопытки;
КонецПроцедуры


