'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('companies', {
    'name': {
      type: DataTypes.STRING,
    },
    'city': {
      type: DataTypes.STRING,
    },
    'country': {
      type: DataTypes.STRING,
    },
    'short_description': {
      type: DataTypes.STRING,
    },
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
    'logo_url': {
      type: DataTypes.STRING,
    },
    'homepage_domain': {
      type: DataTypes.STRING,
    },
    'homepage_url': {
      type: DataTypes.STRING,
    },
    'crunchbase_url': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'companies',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
  };

  return Model;
};

