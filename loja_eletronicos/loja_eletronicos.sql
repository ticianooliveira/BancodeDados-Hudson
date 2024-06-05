PGDMP     %                    |            loja_eletronicos    15.4    15.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24977    loja_eletronicos    DATABASE     �   CREATE DATABASE loja_eletronicos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
     DROP DATABASE loja_eletronicos;
                postgres    false            �            1259    24979    produtos    TABLE     �   CREATE TABLE public.produtos (
    id integer NOT NULL,
    nome character varying(100),
    categoria character varying(100),
    preco numeric(10,2),
    quantidade_vendida integer
);
    DROP TABLE public.produtos;
       public         heap    postgres    false            �            1259    24978    produtos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.produtos_id_seq;
       public          postgres    false    215            	           0    0    produtos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;
          public          postgres    false    214            �            1259    24989    produtos_valor_acima_media    VIEW     �  CREATE VIEW public.produtos_valor_acima_media AS
 SELECT p.nome,
    p.categoria,
    p.preco
   FROM (public.produtos p
     JOIN ( SELECT produtos.categoria,
            avg(produtos.preco) AS media_preco
           FROM public.produtos
          GROUP BY produtos.categoria) subquery ON (((p.categoria)::text = (subquery.categoria)::text)))
  WHERE (p.preco > subquery.media_preco);
 -   DROP VIEW public.produtos_valor_acima_media;
       public          postgres    false    215    215    215            �            1259    24985    quantidade_total_vendida    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW public.quantidade_total_vendida AS
 SELECT produtos.nome,
    sum(produtos.quantidade_vendida) AS total_vendido
   FROM public.produtos
  GROUP BY produtos.nome
  WITH NO DATA;
 8   DROP MATERIALIZED VIEW public.quantidade_total_vendida;
       public         heap    postgres    false    215    215            m           2604    24982    produtos id    DEFAULT     j   ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);
 :   ALTER TABLE public.produtos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215                      0    24979    produtos 
   TABLE DATA           R   COPY public.produtos (id, nome, categoria, preco, quantidade_vendida) FROM stdin;
    public          postgres    false    215   �       
           0    0    produtos_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.produtos_id_seq', 20, true);
          public          postgres    false    214            o           2606    24984    produtos produtos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.produtos DROP CONSTRAINT produtos_pkey;
       public            postgres    false    215                       0    24985    quantidade_total_vendida    MATERIALIZED VIEW DATA     ;   REFRESH MATERIALIZED VIEW public.quantidade_total_vendida;
          public          postgres    false    216    3332               G  x����N1������sw���	+7eZ�q�Ŷ���5�A_�JI����z�sNJ०ڮWJr�T�j�+E���cHQ�&�]4ҩ^x9F	�杧��"��mcl��7��)����h1�Qc�]sM;FQ0��IY�P����p�Q�&_Ԗ�S�&A�YP��\Z"C���� ��nJ�n�8F�����Q�I�V7�'S�����Ѝ�02k�)S�]j�v=x����F0�e��>��I�W�q�v�"�GQju�$���$�j�%��BS*���z���1]r{���c�0̹����<_�u���q     