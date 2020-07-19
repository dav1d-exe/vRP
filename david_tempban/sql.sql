-- Selectati baza de date, apasati pe sql, introduceti comanda de mai jos si executati --

CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `banatdecatre` int(11) NOT NULL DEFAULT 0,
  `motiv` varchar(50) NOT NULL DEFAULT 'Necunoscut',
  `banned` int(11) DEFAULT NULL,
  `timpban` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
