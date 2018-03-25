'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('tools', {
    'name': {
      type: DataTypes.STRING,
    },
    'category': {
      type: DataTypes.STRING,
    },
    'description': {
      type: DataTypes.STRING,
    },
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
    'image_url': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'tools',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
  };

  return Model;
};

