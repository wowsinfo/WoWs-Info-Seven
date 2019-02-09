/**
 * RatingButton.js
 * 
 * 
 */

import React, { Component } from 'react';
import { Button } from 'react-native-paper';
import { getColour, getComment, SafeAction } from '../../core';

class RatingButton extends Component {
  render() {
    const { rating } = this.props;
    if (rating == null || rating === 0) return null;
    return (
      <Button color={getColour(rating)} onPress={() => SafeAction('Rating')}>
        {getComment(rating)}
      </Button>
    );
  };
}

export { RatingButton };
