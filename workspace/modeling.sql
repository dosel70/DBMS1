/*
    요구사항

    대카테고리, 소카테고리가 필요해요.
*/

create table tbl_category_a(
    id bigint primary key,
    category_name varchar(255) not null
);

create table tbl_category_b(
    id bigint primary key,
    category_name varchar(255) not null,
    category_a_id bigint not null,
    constraint fk_category_b_category_a foreign key(category_a_id)
                           references tbl_category_a(id)
);

/*
    요구 사항

    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

*/

create table tbl_member(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    user_rank varchar(255) default '일반회원'
);

create table tbl_office(
    id bigint primary key,
    name varchar(255) not null unique,
    address varchar(255) not null unique
);

create table tbl_conference_room(
    id bigint primary key,
    number int not null unique,
    office_id bigint not null unique,
    constraint fk_conference_room_office foreign key(office_id)
                                references tbl_office(id)
);

create table tbl_part_time(
    id bigint primary key,
    time datetime not null,
    conference_room_id bigint not null,
    constraint fk_part_time_conference_room foreign key(conference_room_id)
                          references tbl_conference_room(id)
);

create table tbl_reservation(
    id bigint primary key,
    start_time datetime not null,
    end_time datetime not null,
    member_id bigint not null,
    conference_room_id bigint not null,
    constraint fk_reservation_member foreign key(member_id)
                            references tbl_member(id),
    constraint fk_reservation_conference_room foreign key(conference_room_id)
                            references tbl_conference_room(id)
);

/*
    요구사항

    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.
*/

create table tbl_parent(
    id bigint primary key,
    name varchar(255) not null,
    age int default 0,
    address varchar(255) not null,
    phone varchar(255) not null,
    gender varchar(255) check ( gender in ('남성', '여성'))
);

create table tbl_child(
    id bigint primary key,
    name varchar(255) not null,
    age int default 0,
    gender varchar(255) check ( gender in ('남성', '여성')),
    parent_id bigint not null,
    constraint fk_child_parent foreign key(parent_id)
                      references tbl_parent(id)
);

create table tbl_field_trip(
    id bigint primary key,
    title varchar(255) not null unique,
    content varchar(255) not null unique
);

create table tbl_event_picture(
    id bigint primary key,
    file_path varchar(255) default '/update/',
    file_name varchar(255) not null,
    field_trip_id bigint not null,
    constraint fk_event_picture_field_trip foreign key(field_trip_id)
                              references tbl_field_trip(id)
);

create table tbl_apply(
    id bigint primary key,
    child_id bigint not null,
    field_trip_id bigint not null,
    constraint fk_apply_child foreign key(child_id)
                      references tbl_child(id),
    constraint fk_apply_field_trip foreign key(field_trip_id)
                      references tbl_field_trip(id)
);

/*
    요구사항

    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.
*/

create table tbl_company(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    company_number varchar(255) not null,
    company_type varchar(255) not null check (company_type in ('스타트업', '중소기업', '중견기업', '대기업') )
);

create table tbl_category_a(
    id bigint primary key,
    name varchar(255) not null
);

create table tbl_category_b(
    id bigint primary key,
    name varchar(255) not null,
    category_a_id bigint not null,
    constraint fk_category_b_category_a foreign key(category_a_id)
                           references tbl_category_a(id)
);

create table tbl_category_c(
    id bigint primary key,
    name varchar(255) not null,
    category_b_id bigint not null,
    constraint fk_category_c_category_b foreign key(category_b_id)
                           references tbl_category_b(id)
);

create table tbl_advertisement(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    category_c_id bigint not null,
    constraint fk_advertisement_category_c foreign key(category_c_id)
                              references tbl_category_c(id)
);

create table tbl_commission(
    id bigint primary key,
    company_id bigint not null,
    advertisement_id bigint not null,
    constraint fk_commission_company foreign key(company_id)
                              references tbl_company(id),
    constraint fk_commission_advertisement foreign key(advertisement_id)
                              references tbl_advertisement(id)
);

drop table tbl_advertisement;

/*
    요구사항

    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.
*/

create table tbl_person(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    email varchar(255)
);

create table tbl_drink(
    id bigint primary key,
    name varchar(255) not null,
    prise int default 0
);

create table tbl_prize(
    id bigint primary key,
    name varchar(255) not null,
    prise int default 0
);

create table tbl_lottery_number(
    id bigint primary key,
    prize_id bigint not null,
    constraint fk_lottery_number_prize foreign key(prize_id)
                               references tbl_prize(id)
);

create table tbl_winning(
    id bigint primary key,
    drink_id bigint not null,
    lottery_number_id bigint not null unique,
    constraint fk_winning_drink foreign key(drink_id)
                        references tbl_drink(id),
    constraint fk_winning_lottery_number foreign key(lottery_number_id)
                        references tbl_lottery_number(id)
);

create table tbl_deliver(
    id bigint primary key,
    deliver_status varchar(255) check ( deliver_status in ('배송 중','배송 완료') ),
    person_id bigint not null,
    prize_id bigint not null,
    constraint fk_deliver_person foreign key(person_id)
                        references tbl_person(id),
    constraint fk_deliver_prize foreign key(prize_id)
                        references tbl_prize(id)
);

/*
    요구사항

    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
    상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
*/

create table tbl_buyer(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null
);

create table tbl_credit_card(
    id bigint primary key,
    company varchar(255) not null,
    buyer_id bigint not null,
    constraint fk_credit_card_buyer foreign key(buyer_id)
                            references tbl_buyer(id)
);

create table tbl_corporation(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    corporation_number  varchar(255) not null
);

create table tbl_product(
    id bigint primary key,
    name varchar(255) not null,
    prise int default 0,
    stoke int default 0,
    corporation_id bigint not null,
    constraint fk_product_corporation foreign key(corporation_id)
                        references tbl_corporation(id)
);

create table tbl_payment(
    id bigint primary key,
    credit_card_id bigint not null,
    product_id bigint not null,
    constraint fk_payment_credit_card foreign key(credit_card_id)
                        references tbl_credit_card(id),
    constraint fk_payment_product foreign key(product_id)
                        references tbl_product(id)
);