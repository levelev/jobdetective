'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('user_tools', {
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
  }, {
    tableName: 'user_tools',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
    Model.belongsTo(models.users, {
      foreignKey: 'user_id',
      
      as: '_user_id',
    });
    
    Model.belongsTo(models.tools, {
      foreignKey: 'tool_id',
      
      as: '_tool_id',
    });
    
  };

  return Model;
};

