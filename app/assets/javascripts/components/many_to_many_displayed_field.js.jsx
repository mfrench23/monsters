var ManyToManyDisplayedField = createReactClass({
  propTypes: {
    title: PropTypes.string,
    text: PropTypes.string
  },

  render: function() {
    return (
      <span title="{this.props.title}" data-displayed_field>{this.props.text}</span>
    );
  }
});

