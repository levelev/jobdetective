'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('ar_internal_metadata', {
    'key': {
      type: DataTypes.STRING,
      primaryKey: true 
    },
    'value': {
      type: DataTypes.STRING,
    },
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
  }, {
    tableName: 'ar_internal_metadata',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
  };

  return Model;
};

